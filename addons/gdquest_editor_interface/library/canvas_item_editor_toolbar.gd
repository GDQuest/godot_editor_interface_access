@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


## The toolbar container of the canvas item editor.
class CanvasItemEditorToolbarDef extends Definition:
	func _init() -> void:
		node_type = "Control"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR

		resolver_steps = [
			Definition.ChildIndexStep.new(0),
			Definition.ChildIndexStep.new(0),
			Definition.ChildIndexStep.new(0),
		]


class CanvasItemEditorToolbarSelectButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 0)
		]


class CanvasItemEditorToolbarMoveButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 1)
		]


class CanvasItemEditorToolbarRotateButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 2)
		]


class CanvasItemEditorToolbarScaleButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 3)
		]


class CanvasItemEditorToolbarSelectableButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 4)
		]


class CanvasItemEditorToolbarPivotButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 5)
		]


class CanvasItemEditorToolbarPanButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 6)
		]


class CanvasItemEditorToolbarRulerButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 7)
		]


class CanvasItemEditorToolbarSmartSnapButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 8)
		]


class CanvasItemEditorToolbarGridButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 9)
		]


class CanvasItemEditorToolbarSnapOptionsButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 10)
		]


class CanvasItemEditorToolbarLockButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 11)
		]


class CanvasItemEditorToolbarUnlockButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 12)
		]


class CanvasItemEditorToolbarGroupButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 13)
		]


class CanvasItemEditorToolbarUngroupButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 14)
		]


class CanvasItemEditorToolbarSkeletonOptionsButtonDef extends Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Definition.ChildTypeStep.new("Button", 15)
		]
