## Editor interface access is a system for serializing, referencing, and retrieving
## editor GUI elements with persistent identifiers.
## Example usage:
##   var EIA := load("res://addons/gdquest_editor_interface/editor_interface_access.gd")
##   var button: Button = EIA.get_node_dynamic(EIA.Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR_SELECTABLE_BUTTON)
##   prints("Result:", button, button.tooltip_text)
@tool

const Enums := preload("./utils/eia_enums.gd")
const Resolver := preload("./utils/eia_resolver.gd")


## Resolves and returns a node in the editor tree associated with the
## given enum value. Returns null if node cannot be resolved.
## Resolved node is cached for future calls.
static func get_node_static(node_point: Enums.NodePoint) -> Node:
	return Resolver.resolve(node_point)


## Analogous to get_node_static(), but does not write resolved nodes
## to the node cache. Existing cache records are respected.
static func get_node_dynamic(node_point: Enums.NodePoint) -> Node:
	return Resolver.resolve(node_point, true)


# Testing.

## Runs resolve (without cache) for every defined node point.
static func test_resolve() -> void:
	print("EIA: Running resolve test...")
	print("----------------------------")

	var total_count := Enums.NodePoint.size()
	var valid_count := 0

	for key: String in Enums.NodePoint:
		print("\t%s:" % [ key ])

		var node_point: int = Enums.NodePoint[key]
		var node := Resolver.resolve(node_point, true)
		if node:
			valid_count += 1
			print("\t\tOK")

	print("----------------------------")
	print("EIA: Resolved nodes: %d / %d" % [ valid_count, total_count ])
