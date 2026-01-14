@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


# The main Window node of the editor, the root node.
class EditorMainWindow extends Definition:
	func _init() -> void:
		node_type = "Window"

		var custom_script := """
EditorInterface.get_base_control().get_window()
"""
		resolver_steps = [
			Definition.CustomStep.new(custom_script),
		]


# The container node for main views/context.
class MainContextContainer extends Definition:
	func _init() -> void:
		node_type = "VBoxContainer"

		var custom_script := """
EditorInterface.get_editor_main_screen()
"""
		resolver_steps = [
			Definition.CustomStep.new(custom_script),
		]
