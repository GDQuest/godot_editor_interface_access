@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


## Main view switcher container, where 2D, 3D, Script, etc
## buttons live.
class MainViewSwitcherDef extends Definition:
	func _init() -> void:
		node_type = "HBoxContainer"
		base_reference = Enums.NodePoint.LAYOUT_TITLE_BAR

		resolver_steps = [
			Definition.NodePathStep.new("EditorMainScreenButtons"),
		]


class MainViewSwitcher2dButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.MAIN_VIEW_SWITCHER

		resolver_steps = [
			Definition.NodePathStep.new("2D")
		]


class MainViewSwitcher3dButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.MAIN_VIEW_SWITCHER

		resolver_steps = [
			Definition.NodePathStep.new("3D")
		]


class MainViewSwitcherScriptButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.MAIN_VIEW_SWITCHER

		resolver_steps = [
			Definition.NodePathStep.new("Script")
		]


class MainViewSwitcherGameButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.MAIN_VIEW_SWITCHER

		resolver_steps = [
			Definition.NodePathStep.new("Game")
		]


class MainViewSwitcherAssetLibButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.MAIN_VIEW_SWITCHER

		resolver_steps = [
			Definition.NodePathStep.new("AssetLib")
		]


## Container node for main views.
class MainViewContainerDef extends Definition:
	func _init() -> void:
		node_type = "EditorMainScreen"
		base_reference = Enums.NodePoint.MAIN_VIEW_CONTAINER_BOX

		resolver_steps = [
			Definition.ParentCountStep.new(1),
		]


## Box layout container for main view panels.
class MainViewContainerBoxDef extends Definition:
	func _init() -> void:
		node_type = "VBoxContainer"

		var custom_script := func(base_node: Node) -> Node:
			return EditorInterface.get_editor_main_screen()

		resolver_steps = [
			Definition.CustomStep.new(custom_script),
		]
