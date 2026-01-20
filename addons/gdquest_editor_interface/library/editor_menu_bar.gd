@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


## Editor's top menu bar (can be a native bar on some platforms).
class MenuBarDef extends Definition:
	func _init() -> void:
		node_type = "MenuBar"
		base_reference = Enums.NodePoint.LAYOUT_TITLE_BAR

		resolver_steps = [
			Definition.ChildTypeStep.new("MenuBar"),
		]


class MenuBarSceneMenuDef extends Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Definition.NodePathStep.new("Scene"),
		]


class MenuBarProjectMenuDef extends Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Definition.NodePathStep.new("Project"),
		]


class MenuBarDebugMenuDef extends Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Definition.NodePathStep.new("Debug"),
		]


class MenuBarEditorMenuDef extends Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Definition.NodePathStep.new("Editor"),
		]


class MenuBarHelpMenuDef extends Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Definition.NodePathStep.new("Help"),
		]
