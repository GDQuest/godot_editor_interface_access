## Node point resolver utility for the editor interface access system.
## It takes definitions from the library folder and tries its best to
## turn them into node references. If a definition depends on another
## definition, this utility will cascadingly resolve all of them.
@tool

const Enums := preload("./eia_enums.gd")
const Definition := preload("./eia_definition.gd")

const LIBRARY_ROOT := "../library"

static var _library_cache: Array[GDScript] = []
static var _library_definition_map: Dictionary[String, GDScript] = {}
static var _node_cache: Dictionary[Enums.NodePoint, Node] = {}

static var _step_resolvers: Dictionary[GDScript, Callable] = {
	Definition.CustomStep:              _resolve_custom_step,
	Definition.ChildTypeStep:           _resolve_child_type_step,
	Definition.ChildIndexStep:          _resolve_child_index_step,
	Definition.SignalCallableStep:      _resolve_signal_callable_step,
}


static func _static_init() -> void:
	_reload_node_point_definitions()


static func resolve(node_point: Enums.NodePoint, skip_cache: bool = false) -> Node:
	if _node_cache.has(node_point):
		return _node_cache[node_point]

	var node_point_name := Enums.get_node_point_name(node_point)
	if node_point_name.is_empty():
		printerr("EIA: Unknown node point value (%d)." % [ node_point ])
		return null

	var definition := _get_node_point_definition(node_point_name)
	if not definition:
		printerr("EIA: Unknown node point definition (%s)." % [ node_point_name ])
		return null

	if definition.resolver_steps.is_empty():
		printerr("EIA: Node point definition (%s) has no resolver steps." % [ node_point_name ])
		return null

	var current_node: Node = null
	if definition.base_reference != -1:
		current_node = resolve(definition.base_reference, skip_cache)

	for i in definition.resolver_steps.size():
		var step := definition.resolver_steps[i]

		if step.get_script() in _step_resolvers:
			var resolver_func := _step_resolvers[step.get_script()]
			if not resolver_func.is_valid():
				printerr("EIA: Invalid method associated with resolver step type (%s) in step %d." % [ step, i ])
				current_node = null
			else:
				current_node = resolver_func.call(step, i, current_node)
			continue

		printerr("EIA: Unknown resolver step type (%s) in step %d." % [ step, i ])
		current_node = null

	if current_node:
		var current_node_type := current_node.get_class()
		var expected_node_type := definition.node_type

		if not ClassDB.is_parent_class(current_node_type, expected_node_type):
			printerr("EIA: Resolved node (%s) doesn't match or inherit expected type (%s)." % [ current_node_type, expected_node_type ])
			return null

	if not skip_cache && current_node:
		_node_cache[node_point] = current_node

	return current_node


# Helpers.

static func _reload_node_point_definitions() -> void:
	_library_cache.clear()
	_library_definition_map.clear()

	var library_root := _get_library_root()
	var fs := DirAccess.open(library_root)
	var error := DirAccess.get_open_error()
	if error != OK:
		printerr("EIA: Failed to open library root for reading (code %d)." % [ error ])
		return

	error = fs.list_dir_begin()
	if error != OK:
		printerr("EIA: Failed to start library root listing (code %d)." % [ error ])
		return

	# Automatically load every GDScript file from the library folder.
	var file_name := fs.get_next()
	while not file_name.is_empty():
		if not file_name.ends_with(".gd"):
			file_name = fs.get_next()
			continue

		var script_path := library_root.path_join(file_name)
		var script: GDScript = load(script_path)
		if not script:
			printerr("EIA: Failed to load library file at '%s'." % [ script_path ])
			file_name = fs.get_next()
			continue

		# Keep a reference around so it doesn't get freed by accident.
		_library_cache.push_back(script)

		# Get all inner classes via the constant map.
		for name: String in script.get_script_constant_map():
			if script[name].get_base_script() != Definition:
				continue

			# Classes have a suffix to avoid naming collisions, but enums do not
			# because they are public API of this library.
			var clean_name := name.trim_suffix("Def")
			_library_definition_map[clean_name] = script[name]

		file_name = fs.get_next()


static func _get_node_point_definition(name: String) -> Definition:
	if not _library_definition_map.has(name):
		return null

	return _library_definition_map[name].new()


static func _get_library_root() -> String:
	## HACK: A simple hack to get current path from a static context.
	var library_root := (Definition as Script).resource_path
	library_root = library_root.get_base_dir()
	library_root = library_root.path_join(LIBRARY_ROOT)

	return library_root.simplify_path()


# Step resolvers.

static func _resolve_custom_step(step: Definition.CustomStep, step_index: int, base_node: Node) -> Node:
	var script_lines := step.script_code.split("\n")
	if script_lines.is_empty():
		return null

	var last_line := script_lines[-1]
	if not last_line.begins_with("return "):
		script_lines[-1] = "return %s" % [ last_line ]

	var script_text := """
@tool
extends RefCounted

func _custom_resolve(base_node: Node) -> Node:
"""

	for line in script_lines:
		script_text += "\t" + line + "\n"

	script_text += """
	pass # Safely end the method body.
"""

	var script := GDScript.new()
	script.source_code = script_text
	var script_status := script.reload()
	if script_status != OK:
		printerr("EIS: Custom resolver code in step %d is invalid and failed to run." % [ step_index ])
		return null

	var script_instance = script.new()
	if not script_instance.has_method("_custom_resolve"):
		printerr("EIS: Custom resolver code in step %d is invalid and failed to run (_custom_resolve() method not found)." % [ step_index ])
		return null

	return script_instance.call("_custom_resolve", base_node)


static func _resolve_child_type_step(step: Definition.ChildTypeStep, step_index: int, base_node: Node) -> Node:
	if not base_node:
		return null

	var counter := -1
	for child_node in base_node.get_children():
		if ClassDB.is_parent_class(child_node.get_class(), step.type_name):
			counter += 1
			if counter == step.type_index:
				return child_node

	printerr("EIS: Child type resolver in step %d expected to find %d '%s' node(s), but failed." % [ step_index, (step.type_index + 1), step.type_name ])
	return null


static func _resolve_child_index_step(step: Definition.ChildIndexStep, step_index: int, base_node: Node) -> Node:
	if not base_node:
		return null

	if base_node.get_child_count() <= step.child_index:
		printerr("EIS: Child index resolver in step %d expected to find at least %d children, but failed." % [ step_index, (step.child_index + 1) ])
		return null

	return base_node.get_child(step.child_index)


static func _resolve_signal_callable_step(step: Definition.SignalCallableStep, step_index: int, base_node: Node) -> Node:
	if not base_node:
		return null

	var signal_ref: Signal = base_node[step.signal_name]
	if not signal_ref:
		return null

	for connection_info in signal_ref.get_connections():
		var object_ref := (connection_info["callable"] as Callable).get_object()

		if ClassDB.is_parent_class(object_ref.get_class(), step.object_type_name):
			return object_ref

	printerr("EIS: Signal callable resolver in step %d expected to find '%s' node, but failed." % [ step_index, step.object_type_name ])
	return null
