@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_resolver_types.gd")
const Utils := preload("../utils/eia_resolver_utils.gd")


class SceneDockDef extends Types.Definition:
	func _init() -> void:
		node_type = "SceneTreeDock"

		var custom_script := func(base_node: Node) -> Node:
			var es := EditorInterface.get_selection()
			return Utils.object_get_signal_type(es, "selection_changed", "SceneTreeDock")

		resolver_steps = [
			Types.DoCustomStep.new(custom_script),
		]


class SceneTreeEditorDef extends Types.Definition:
	func _init() -> void:
		node_type = "SceneTreeEditor"

		var custom_script := func(base_node: Node) -> Node:
			var es := EditorInterface.get_selection()
			return Utils.object_get_signal_type(es, "selection_changed", "SceneTreeEditor")

		resolver_steps = [
			Types.DoCustomStep.new(custom_script),
		]


class SceneTreeEditorTreeDef extends Types.Definition:
	func _init() -> void:
		node_type = "Tree"
		base_reference = Enums.NodePoint.SCENE_TREE_EDITOR

		resolver_steps = [
			Types.GetChildTypeStep.new("Tree"),
		]
