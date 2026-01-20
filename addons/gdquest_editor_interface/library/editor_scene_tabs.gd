@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


class SceneTabsDef extends Definition:
	func _init() -> void:
		node_type = "EditorSceneTabs"
		base_reference = Enums.NodePoint.MAIN_VIEW_CONTAINER

		resolver_steps = [
			Definition.ParentCountStep.new(1),
			Definition.ChildTypeStep.new("EditorSceneTabs")
		]


class SceneTabsTabBarDef extends Definition:
	func _init() -> void:
		node_type = "TabBar"
		base_reference = Enums.NodePoint.SCENE_TABS

		resolver_steps = [
			Definition.FindTypeStep.new("TabBar"),
		]


class SceneTabsAddButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.SCENE_TABS_TAB_BAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button"),
		]
