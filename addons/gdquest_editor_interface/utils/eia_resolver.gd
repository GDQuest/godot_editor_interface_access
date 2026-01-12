## Node point resolver utility for the editor interface access system.
## It takes definitions from the library folder and tries its best to
## turn them into node references. If a definition depends on another
## definition, this utility will cascadingly resolve all of them.
@tool

const Definition := preload("./eia_definition.gd")

const LIBRARY_ROOT := "../library"
const LIBRARY_EXT := "def"

static var _node_cache: Dictionary[int, Node] = {}


static func resolve(node_group: String, node_key: String, node_point: int, skip_cache: bool = false) -> Node:
	if _node_cache.has(node_point):
		return _node_cache[node_point]

	var definition := _get_node_point_definition(node_group, node_key, node_point)
	if not definition:
		print("EIA: Failed to load node point definition (%s, %s, %d)." % [ node_group, node_key, node_point ])
		return null

	var current_node: Node = null
	if definition.base_reference_point != -1:
		current_node = resolve(definition.base_reference_group, definition.base_reference_key, definition.base_reference_point, skip_cache)

	for step in definition.resolver_steps:
		if step is Definition.CustomStep:
			current_node = _resolve_custom_step(step, current_node)
		elif step is Definition.TypeStep:
			current_node = _resolve_type_step(step, current_node)
		elif step is Definition.IndexStep:
			current_node = _resolve_index_step(step, current_node)

		else:
			current_node = null

	if current_node:
		var current_node_type := current_node.get_class()
		if not ClassDB.is_parent_class(current_node_type, definition.node_type):
			print("EIA: Resolved node (%s) doesn't match or inherit expected type (%s)." % [ current_node_type, definition.node_type ])
			return null

	if not skip_cache && current_node:
		_node_cache[node_point] = current_node

	return current_node


# Helpers.

static func _get_node_point_definition(node_group: String, node_key: String, node_point: int) -> Definition:
	var library_root := _get_library_root()

	var folder_name := node_group.to_snake_case().trim_prefix("np_")
	var file_name := "%s.%s" % [ node_key.to_lower(), LIBRARY_EXT ]
	var file_path := folder_name.path_join(file_name)

	var fs := DirAccess.open(library_root)
	var error := DirAccess.get_open_error()
	if error != OK:
		print("EIA: Failed to open library root for reading (code %d)." % [ error ])
		return null

	if not fs.file_exists(file_path):
		print("EIA: Definition file at '%s' doesn't exist." % [ file_path ])
		return null

	var config := ConfigFile.new()
	error = config.load(library_root.path_join(file_path))
	if error != OK:
		print("EIA: Failed to load definition file at '%s' (code %d)." % [ file_path, error ])
		return null

	var definition := Definition.new()
	if not definition.parse(config):
		print("EIA: Failed to parse definition file at '%s'." % [ file_path ])
		return null

	return definition


## A simple hack to get current path from a static context.
static func _get_library_root() -> String:
	var library_root := (Definition as Script).resource_path
	library_root = library_root.get_base_dir()
	library_root = library_root.path_join(LIBRARY_ROOT)

	return library_root.simplify_path()


# Step resolvers.

static func _resolve_custom_step(step: Definition.CustomStep, base_node: Node) -> Node:
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
		print("EIS: Custom resolver code in step '%s' is invalid and failed to run." % [ step.step_key ])
		return null

	var script_instance = script.new()
	if not script_instance.has_method("_custom_resolve"):
		print("EIS: Custom resolver code in step '%s' is invalid and failed to run (_custom_resolve() method not found)." % [ step.step_key ])
		return

	return script_instance.call("_custom_resolve", base_node)


static func _resolve_type_step(step: Definition.TypeStep, base_node: Node) -> Node:
	if not base_node:
		return null

	var counter := -1
	for child_node in base_node.get_children():
		if ClassDB.is_parent_class(child_node.get_class(), step.type_name):
			counter += 1
			if counter == step.type_index:
				return child_node

	print("EIS: Type resolver in step '%s' expected to find %d '%s' node(s), but failed." % [ step.step_key, (step.type_index + 1), step.type_name ])
	return null


static func _resolve_index_step(step: Definition.IndexStep, base_node: Node) -> Node:
	if not base_node:
		return null

	if base_node.get_child_count() <= step.child_index:
		print("EIS: Index resolver in step '%s' expected to find at least %d children, but failed." % [ step.step_key, (step.child_index + 1) ])
		return null

	return base_node.get_child(step.child_index)
