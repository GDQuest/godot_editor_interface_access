@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_types.gd")


## The main Window node of the editor, the root node.
class EditorMainWindowDef extends Types.Definition:
	func _init() -> void:
		node_type = "Window"

		var custom_script := func(base_node: Node) -> Node:
			return EditorInterface.get_base_control().get_window()

		resolver_steps = [
			Types.CustomStep.new(custom_script),
		]


## Main logical node of the editor.
class EditorNodeDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorNode"
		base_reference = Enums.NodePoint.EDITOR_MAIN_WINDOW

		resolver_steps = [
			Types.ChildTypeStep.new("EditorNode"),
		]


## Editor virtual file system object, which happens to be a node
## (likely for processing).
class EditorFileSystemDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorFileSystem"

		var custom_script := func(base_node: Node) -> Node:
			return EditorInterface.get_resource_filesystem()

		resolver_steps = [
			Types.CustomStep.new(custom_script),
		]


## Editor export manager object, which happens to be a node
## (likely for processing).
class EditorExportDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorExport"
		base_reference = Enums.NodePoint.EDITOR_NODE

		resolver_steps = [
			Types.ChildTypeStep.new("EditorExport"),
		]


## Root Control node for the editor GUI.
class LayoutRootDef extends Types.Definition:
	func _init() -> void:
		node_type = "Panel"

		var custom_script := func(base_node: Node) -> Node:
			return EditorInterface.get_base_control()

		resolver_steps = [
			Types.CustomStep.new(custom_script),
		]


class LayoutTitleBarDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorTitleBar"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		# Parent node can be either VBoxContainer or HBoxContainer, depending on platform,
		# but title bar is always directly there.
		resolver_steps = [
			Types.ChildIndexStep.new(0),
			Types.ChildTypeStep.new("EditorTitleBar"),
		]
