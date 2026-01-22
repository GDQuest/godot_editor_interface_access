@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_types.gd")


class RunBarDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorRunBar"
		base_reference = Enums.NodePoint.LAYOUT_TITLE_BAR

		resolver_steps = [
			Types.ChildTypeStep.new("EditorRunBar"),
		]
