@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


class RunBarDef extends Definition:
	func _init() -> void:
		node_type = "EditorRunBar"
		base_reference = Enums.NodePoint.LAYOUT_TITLE_BAR

		resolver_steps = [
			Definition.ChildTypeStep.new("EditorRunBar"),
		]
