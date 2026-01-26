@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_resolver_types.gd")


## The main Window node of the editor, the root node.
class EditorMainWindowDef extends Types.Definition:
	func _init() -> void:
		node_type = "Window"

		var custom_script := func(base_node: Node) -> Node:
			return EditorInterface.get_base_control().get_window()

		resolver_steps = [
			Types.DoCustomStep.new(custom_script),
		]


## Main logical node of the editor.
class EditorNodeDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorNode"
		base_reference = Enums.NodePoint.EDITOR_MAIN_WINDOW

		resolver_steps = [
			Types.GetChildTypeStep.new("EditorNode"),
		]


## Editor virtual file system object, which happens to be a node
## (likely for processing).
class EditorFileSystemDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorFileSystem"

		var custom_script := func(base_node: Node) -> Node:
			return EditorInterface.get_resource_filesystem()

		resolver_steps = [
			Types.DoCustomStep.new(custom_script),
		]


## Editor export manager object, which happens to be a node
## (likely for processing).
class EditorExportDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorExport"
		base_reference = Enums.NodePoint.EDITOR_NODE

		resolver_steps = [
			Types.GetChildTypeStep.new("EditorExport"),
		]


## Root Control node for the editor GUI.
class LayoutRootDef extends Types.Definition:
	func _init() -> void:
		node_type = "Panel"

		var custom_script := func(base_node: Node) -> Node:
			return EditorInterface.get_base_control()

		resolver_steps = [
			Types.DoCustomStep.new(custom_script),
		]


class LayoutTitleBarDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorTitleBar"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		# Parent node can be either VBoxContainer or HBoxContainer, depending on platform,
		# but title bar is always directly there.
		resolver_steps = [
			Types.GetChildIndexStep.new(0),
			Types.GetChildTypeStep.new("EditorTitleBar"),
		]


class LayoutDockLeftLeftTopDef extends Types.Definition:
	func _init() -> void:
		node_type = "TabContainer"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildIndexStep.new(0),
			Types.GetNodePathStep.new("DockHSplitMain/DockVSplitLeftL/DockSlotLeftUL"),
		]


class LayoutDockLeftLeftBottomDef extends Types.Definition:
	func _init() -> void:
		node_type = "TabContainer"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildIndexStep.new(0),
			Types.GetNodePathStep.new("DockHSplitMain/DockVSplitLeftL/DockSlotLeftBL"),
		]


class LayoutDockLeftRightTopDef extends Types.Definition:
	func _init() -> void:
		node_type = "TabContainer"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildIndexStep.new(0),
			Types.GetNodePathStep.new("DockHSplitMain/DockVSplitLeftR/DockSlotLeftUR"),
		]


class LayoutDockLeftRightBottomDef extends Types.Definition:
	func _init() -> void:
		node_type = "TabContainer"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildIndexStep.new(0),
			Types.GetNodePathStep.new("DockHSplitMain/DockVSplitLeftR/DockSlotLeftBR"),
		]


class LayoutDockRightLeftTopDef extends Types.Definition:
	func _init() -> void:
		node_type = "TabContainer"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildIndexStep.new(0),
			Types.GetNodePathStep.new("DockHSplitMain/DockVSplitRightL/DockSlotRightUL"),
		]


class LayoutDockRightLeftBottomDef extends Types.Definition:
	func _init() -> void:
		node_type = "TabContainer"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildIndexStep.new(0),
			Types.GetNodePathStep.new("DockHSplitMain/DockVSplitRightL/DockSlotRightBL"),
		]


class LayoutDockRightRightTopDef extends Types.Definition:
	func _init() -> void:
		node_type = "TabContainer"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildIndexStep.new(0),
			Types.GetNodePathStep.new("DockHSplitMain/DockVSplitRightR/DockSlotRightUR"),
		]


class LayoutDockRightRightBottomDef extends Types.Definition:
	func _init() -> void:
		node_type = "TabContainer"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildIndexStep.new(0),
			Types.GetNodePathStep.new("DockHSplitMain/DockVSplitRightR/DockSlotRightBR"),
		]


class LayoutDockMiddleBottomDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorBottomPanel"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildIndexStep.new(0),
			Types.GetNodePathStep.new("DockHSplitMain"),
			Types.GetChildTypeStep.new("VBoxContainer", 0),
			Types.GetNodePathStep.new("DockVSplitCenter"),
			Types.GetChildTypeStep.new("EditorBottomPanel"),
		]


class LayoutDockHiddenContainerDef extends Types.Definition:
	func _init() -> void:
		node_type = "Control"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		# To reinforce the fetch here we can check that there is at least one
		# EditorDock child. It's very unlikely that the control will be empty,
		# especially at launch. But at this time its order is fixed, so eh.
		resolver_steps = [
			Types.GetChildIndexStep.new(1),
		]
