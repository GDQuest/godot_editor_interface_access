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
## given node point value. Returns null if the node, or one of its
## pre-requisites, cannot be resolved.
## Resolved node is cached for future calls, unless the skip_cache
## flag is set.
static func get_node(node_point: Enums.NodePoint, skip_cache: bool = false) -> Node:
	return Resolver.resolve_node(node_point, null, skip_cache)


## Resolves and returns a node in the editor tree associated with the
## given node point value, relative to the given base node. If the
## definition for this node point has a base reference, it will be ignored.
## Returns null if the node, or one of its pre-requisites, cannot be resolved.
## Resolved nodes are never cached.
static func get_node_relative(base_node: Node, node_point: Enums.NodePoint) -> Node:
	return Resolver.resolve_node(node_point, base_node, true)


# Testing.

## Runs resolve (without cache) for every defined node point.
static func test_resolve(skip_cache: bool = false) -> void:
	print("[EIA] Running resolve test...")
	print("----------------------------")

	var total_count := Enums.NodePoint.size()
	var valid_count := 0
	var skipped_count := 0

	for key: String in Enums.NodePoint:
		print("\t%s:" % [ key ])
		var node_point: int = Enums.NodePoint[key]

		if node_point >= 100_000_000: # Reusable nodes cannot be tested without context.
			skipped_count += 1
			print_rich("\t\t[i]SKIPPED[/i] (reusable)")
			continue

		var node := Resolver.resolve_node(node_point, null, skip_cache)
		if node:
			valid_count += 1
			print_rich("\t\t[b]OK[/b]")

	print("----------------------------")
	print_rich("[EIA] Resolved successfully: [b]%d / %d[/b]" % [ valid_count, total_count - skipped_count ])
	print_rich("              excl. skipped: [b]%d[/b]" % [ skipped_count ])
