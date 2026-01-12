## Editor interface access is a system for serializing, referencing, and retrieving
## editor GUI elements with persistent identifiers.
## Example usage:
##   var EIA := load("res://addons/gdquest_editor_interface/editor_interface_access.gd")
##   prints("Result:", EIA.get_node_static(EIA.Enums.NPCanvasEditor, EIA.Enums.NPCanvasEditor.CANVAS_ITEM_EDITOR_TOOLBAR))
@tool

const Enums := preload("./utils/eia_enums.gd")
const Resolver := preload("./utils/eia_resolver.gd")


## Resolves and returns a node in the editor tree associated with the
## given enum value. Returns null if node cannot be resolved.
## Resolved node is cached for future calls.
static func get_node_static(node_enum: Dictionary, node_point: int) -> Node:
	var enum_name := Enums.get_enum_name(node_enum)
	var enum_key := Enums.get_enum_key(node_enum, node_point)

	return Resolver.resolve(enum_name, enum_key, node_point)


## Analogous to get_node_static(), but does not write resolved nodes
## to the node cache. Existing cache records are respected.
static func get_node_dynamic(node_enum: Dictionary, node_point: int) -> Node:
	var enum_name := Enums.get_enum_name(node_enum)
	var enum_key := Enums.get_enum_key(node_enum, node_point)

	return Resolver.resolve(enum_name, enum_key, node_point, true)
