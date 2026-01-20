@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


class HistoryDockDef extends Definition:
	func _init() -> void:
		node_type = "HistoryDock"
		base_reference = Enums.NodePoint.EDITOR_NODE

		resolver_steps = [
			Definition.SignalCallableStep.new("scene_changed", "HistoryDock"),
		]
