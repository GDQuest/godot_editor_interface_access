@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


## The root node of the canvas item editor (main 2D view).
class CanvasItemEditorDef extends Definition:
	func _init() -> void:
		node_type = "CanvasItemEditor"
		base_reference = Enums.NodePoint.MAIN_CONTEXT_CONTAINER

		resolver_steps = [
			Definition.TypeStep.new("CanvasItemEditor"),
		]
