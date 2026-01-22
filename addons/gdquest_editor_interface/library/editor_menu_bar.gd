@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_types.gd")


## Editor's top menu bar (can be a native bar on some platforms).
class MenuBarDef extends Types.Definition:
	func _init() -> void:
		node_type = "MenuBar"
		base_reference = Enums.NodePoint.LAYOUT_TITLE_BAR

		resolver_steps = [
			Types.ChildTypeStep.new("MenuBar"),
		]


class MenuBarSceneMenuDef extends Types.Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Types.NodePathStep.new("Scene"),
		]


class MenuBarProjectMenuDef extends Types.Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Types.NodePathStep.new("Project"),
		]


class MenuBarDebugMenuDef extends Types.Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Types.NodePathStep.new("Debug"),
		]


class MenuBarEditorMenuDef extends Types.Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Types.NodePathStep.new("Editor"),
		]


class MenuBarHelpMenuDef extends Types.Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Types.NodePathStep.new("Help"),
		]
