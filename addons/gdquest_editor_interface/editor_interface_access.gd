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


static func get_dock_tabs(dock_node: EditorDock) -> TabBar:
	var dock_owner := dock_node.get_parent()
	if not dock_owner || not ClassDB.is_parent_class(dock_owner.get_class(), "TabContainer"):
		return null

	return (dock_owner as TabContainer).get_tab_bar()


# Testing.

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
			if _test_resolve_relative(node_point, skip_cache):
				valid_count += 1
				last_valid_count += 1
				print_rich("\t\t[b]OK[/b]")
			else:
				skipped_count += 1
				last_skipped_count += 1
				print_rich("\t\t[i]SKIPPED[/i] (reusable)")

			continue # Continue regardless.

		if Resolver.resolve_node(node_point, null, skip_cache):
			valid_count += 1
			last_valid_count += 1
			print_rich("\t\t[b]OK[/b]")

	print("")
	print_rich("\tin section resolved successfully: [b]%d / %d[/b]" % [ last_valid_count, last_total_count - last_skipped_count ])
	print_rich("\t                   excl. skipped: [b]%d[/b]" % [ last_skipped_count ])

	print("========================================")
	print_rich("[EIA] Resolved successfully: [b]%d / %d[/b]" % [ valid_count, total_count - skipped_count ])
	print_rich("              excl. skipped: [b]%d[/b]" % [ skipped_count ])


static func _test_resolve_relative(node_point: Enums.NodePoint, skip_cache: bool) -> Node:
	# Reusable nodes need some context point to test against. We
	# have to hardcode logic for each group to supply these contexts.
	# The editor also needs to be in a certain state for all nodes
	# to resolve successfully.

	# These should be implemented in a reverse order, to simplify
	# the checks.

	#
	if node_point >= Enums.NodePoint.CREATE_OBJECT_DIALOG_PANELS:
		var scene_create_dialog := get_node(Enums.NodePoint.SCENE_DOCK_CREATE_DIALOG, true) # Don't write to cache here.
		return get_node_relative(scene_create_dialog, node_point, skip_cache)

	#
	if node_point >= Enums.NodePoint.EDITOR_ZOOM_WIDGET_ZOOM_OUT_BUTTON:
		var zoom_widget := get_node(Enums.NodePoint.TILE_MAP_TILES_ATLAS_VIEW_ZOOM_WIDGET, true) # Don't write to cache here.
		return get_node_relative(zoom_widget, node_point, skip_cache)

	# Can fail if there is no help page or it's not fully initialized yet
	# (must be opened by the user at least once).
	if node_point >= Enums.NodePoint.EDITOR_HELP_RICH_TEXT:
		var script_tabs: TabContainer = get_node(Enums.NodePoint.SCRIPT_EDITOR_CONTAINER_TABS, true) # Don't write to cache here.
		for tab_index in script_tabs.get_tab_count():
			var tab_control := script_tabs.get_tab_control(tab_index)
			if ClassDB.is_parent_class(tab_control.get_class(), "EditorHelp"):
				return get_node_relative(tab_control, node_point, skip_cache)

		push_error("[EIA] No 'EditorHelp' node present in the Script editor view.")
		return null

	# Can fail if there is no text editor or it's not fully initialized yet
	# (must be opened by the user at least once).
	if node_point >= Enums.NodePoint.TEXT_EDITOR_CODE_EDITOR:
		var script_tabs: TabContainer = get_node(Enums.NodePoint.SCRIPT_EDITOR_CONTAINER_TABS, true) # Don't write to cache here.
		for tab_index in script_tabs.get_tab_count():
			var tab_control := script_tabs.get_tab_control(tab_index)
			if ClassDB.is_parent_class(tab_control.get_class(), "TextEditor"):
				return get_node_relative(tab_control, node_point, skip_cache)

		push_error("[EIA] No 'TextEditor' node present in the Script editor view.")
		return null

	# Can fail if there is no code editor or it's not fully initialized yet
	# (must be opened by the user at least once).
	if node_point >= Enums.NodePoint.SCRIPT_TEXT_EDITOR_CODE_EDITOR:
		var script_tabs: TabContainer = get_node(Enums.NodePoint.SCRIPT_EDITOR_CONTAINER_TABS, true) # Don't write to cache here.
		for tab_index in script_tabs.get_tab_count():
			var tab_control := script_tabs.get_tab_control(tab_index)
			if ClassDB.is_parent_class(tab_control.get_class(), "ScriptTextEditor"):
				return get_node_relative(tab_control, node_point, skip_cache)

		push_error("[EIA] No 'ScriptTextEditor' node present in the Script editor view.")
		return null

	#
	if node_point >= Enums.NodePoint.NODE_3D_EDITOR_VIEWPORT_SCENE_ROOT:
		var viewports_container := get_node(Enums.NodePoint.NODE_3D_EDITOR_VIEWPORTS, true) # Don't write to cache here.
		var viewports := viewports_container.find_children("", "Node3DEditorViewport", false, false)
		if viewports.is_empty():
			return null

		return get_node_relative(viewports[0], node_point, skip_cache)

	var node_point_name := Enums.get_node_point_name(node_point)
	push_error("[EIA] Invalid relative node point '%s'." % [ node_point_name ])
	return null
