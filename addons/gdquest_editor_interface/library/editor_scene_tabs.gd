@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_resolver_types.gd")


class SceneTabsDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorSceneTabs"
		base_reference = Enums.NodePoint.MAIN_VIEW_CONTAINER

		resolver_steps = [
			Types.GetParentCountStep.new(1),
			Types.GetChildTypeStep.new("EditorSceneTabs")
		]


class SceneTabsTabBarDef extends Types.Definition:
	func _init() -> void:
		node_type = "TabBar"
		base_reference = Enums.NodePoint.SCENE_TABS

		resolver_steps = [
			Types.FindNodeTypeStep.new("TabBar"),
		]


class SceneTabsAddButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.SCENE_TABS_TAB_BAR

		resolver_steps = [
			Types.GetChildTypeStep.new("Button"),
		]
