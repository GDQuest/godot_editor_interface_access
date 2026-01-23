@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_resolver_types.gd")


## Editor's top menu bar (can be a native bar on some platforms).
class MenuBarDef extends Types.Definition:
	func _init() -> void:
		node_type = "MenuBar"
		base_reference = Enums.NodePoint.LAYOUT_TITLE_BAR

		resolver_steps = [
			Types.GetChildTypeStep.new("MenuBar"),
		]


class MenuBarSceneMenuDef extends Types.Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Types.GetNodePathStep.new("Scene"),
		]


class MenuBarProjectMenuDef extends Types.Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Types.GetNodePathStep.new("Project"),
		]


class MenuBarDebugMenuDef extends Types.Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Types.GetNodePathStep.new("Debug"),
		]


class MenuBarEditorMenuDef extends Types.Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Types.GetNodePathStep.new("Editor"),
		]


class MenuBarHelpMenuDef extends Types.Definition:
	func _init() -> void:
		node_type = "PopupMenu"
		base_reference = Enums.NodePoint.MENU_BAR

		resolver_steps = [
			Types.GetNodePathStep.new("Help"),
		]
