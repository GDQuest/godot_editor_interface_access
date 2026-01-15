@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


## The main Window node of the editor, the root node.
class EditorMainWindowDef extends Definition:
	func _init() -> void:
		node_type = "Window"

		var custom_script := """
EditorInterface.get_base_control().get_window()
"""
		resolver_steps = [
			Definition.CustomStep.new(custom_script),
		]


## Main logical node of the editor.
class EditorNodeDef extends Definition:
	func _init() -> void:
		node_type = "EditorNode"
		base_reference = Enums.NodePoint.EDITOR_MAIN_WINDOW

		resolver_steps = [
			Definition.ChildTypeStep.new("EditorNode"),
		]


## Editor virtual file system object, which happens to be a node
## (likely for processing).
class EditorFileSystemDef extends Definition:
	func _init() -> void:
		node_type = "EditorFileSystem"

		var custom_script := """
EditorInterface.get_resource_filesystem()
"""
		resolver_steps = [
			Definition.CustomStep.new(custom_script),
		]


## The container node for main views/context.
class MainContextContainerDef extends Definition:
	func _init() -> void:
		node_type = "VBoxContainer"

		var custom_script := """
EditorInterface.get_editor_main_screen()
"""
		resolver_steps = [
			Definition.CustomStep.new(custom_script),
		]
