## Node point resolver utility for the editor interface access system.
## It takes definitions from the library folder and tries its best to
## turn them into node references. If a definition depends on another
## definition, this utility will cascadingly resolve all of them.
@tool

const Definition := preload("./eia_definition.gd")

const LIBRARY_ROOT := "../library"
const LIBRARY_EXT := "def"

static var _node_cache: Dictionary[int, Node] = {}


static func resolve(node_group: String, node_key: String, node_point: int) -> Node:
	if _node_cache.has(node_point):
		return _node_cache[node_point]

	var definition := get_node_point_definition(node_group, node_key, node_point)
	if not definition:
		return null

	var current_node: Node = null
	for step in definition.resolver_steps:
		current_node = step.resolve(current_node)

	if current_node:
		_node_cache[node_point] = current_node

	return current_node


static func get_node_point_definition(node_group: String, node_key: String, node_point: int) -> Definition:
	var library_root := get_library_root()

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
static func get_library_root() -> String:
	var library_root := (Definition as Script).resource_path
	library_root = library_root.get_base_dir()
	library_root = library_root.path_join(LIBRARY_ROOT)

	return library_root.simplify_path()
