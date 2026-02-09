## Editor interface access is a system for serializing, referencing, and retrieving
## editor GUI elements with persistent identifiers.
## Example usage:
##   var EIA := load("res://addons/gdquest_editor_interface/editor_interface_access.gd")
##   var button: Button = EIA.get_node_dynamic(EIA.Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_SELECTABLE_BUTTON)
##   prints("Result:", button, button.tooltip_text)
@tool

const Enums := preload("./utils/eia_enums.gd")
const Resolver := preload("./utils/eia_resolver.gd")


# Node access.

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
static func get_node_relative(base_node: Node, node_point: Enums.NodePoint, skip_cache: bool = false) -> Node:
	return Resolver.resolve_node(node_point, base_node, skip_cache)


# Helpers.

static func get_node_3d_viewport(viewport_index: int) -> Control:
	var viewports_container := get_node(Enums.NodePoint.NODE_3D_EDITOR_VIEWPORTS)
	var viewports := viewports_container.find_children("", "Node3DEditorViewport", false, false)

	if viewport_index < 0 || viewport_index >= viewports.size():
		return null

	return viewports[viewport_index]


static func is_script_editor_active() -> bool:
	var script_editor := get_node(Enums.NodePoint.SCRIPT_EDITOR)
	if not script_editor:
		return false # Should never happen.

	var script_window := script_editor.get_window()

	# The editor is embedded in the main window, just check if the script
	# editor is visible.
	if script_window == script_editor.get_tree().root:
		return script_editor.is_visible_in_tree()

	# The editor is floating, has its own window. Check if it's focused.
	if script_window == Window.get_focused_window():
		return true

	return false


static func get_script_editor_tab(tab_index: int) -> Control:
	# NOTE: Script editor tabs at first exist in an "uninstantiated" mode,
	# until the user clicks on it and the actual contents are spawned. It's
	# probably a performance/memory saving measure, but that means we cannot
	# be sure internal elements exist.

	var script_tabs: TabContainer = get_node(Enums.NodePoint.SCRIPT_EDITOR_CONTAINER_TABS)
	if tab_index < 0 || tab_index >= script_tabs.get_tab_count():
		return null

	return script_tabs.get_tab_control(tab_index)


# Testing.

# TODO: Add tests for reusable nodes.
# Conceptually it can work only if we provide specific starting points for each rule,
# which sounds not very manageable.

## Runs resolve (without cache) for every defined node point.
static func test_resolve(skip_cache: bool = false) -> void:
	print("[EIA] Running resolve test...")
	print("========================================")

	var total_count := Enums.NodePoint.size()
	var valid_count := 0
	var skipped_count := 0

	var last_node_point := -1
	var last_total_count := 0
	var last_valid_count := 0
	var last_skipped_count := 0

	for key: String in Enums.NodePoint:
		var node_point: int = Enums.NodePoint[key]
		if last_node_point != -1 && (last_node_point + 1) != node_point:
			print("")
			print_rich("\tin section resolved successfully: [b]%d / %d[/b]" % [ last_valid_count, last_total_count - last_skipped_count ])
			print_rich("\t                   excl. skipped: [b]%d[/b]" % [ last_skipped_count ])
			print("----------------------------------------")

			last_total_count = 0
			last_valid_count = 0
			last_skipped_count = 0

		last_node_point = node_point
		last_total_count += 1

		print("\t%s:" % [ key ])

		if Resolver.is_node_relative(node_point): # Reusable nodes cannot be tested without context.
			skipped_count += 1
			last_skipped_count += 1
			print_rich("\t\t[i]SKIPPED[/i] (reusable)")
			continue

		var node := Resolver.resolve_node(node_point, null, skip_cache)
		if node:
			valid_count += 1
			last_valid_count += 1
			print_rich("\t\t[b]OK[/b]")

	print("")
	print_rich("\tin section resolved successfully: [b]%d / %d[/b]" % [ last_valid_count, last_total_count - last_skipped_count ])
	print_rich("\t                   excl. skipped: [b]%d[/b]" % [ last_skipped_count ])

	print("========================================")
	print_rich("[EIA] Resolved successfully: [b]%d / %d[/b]" % [ valid_count, total_count - skipped_count ])
	print_rich("              excl. skipped: [b]%d[/b]" % [ skipped_count ])
