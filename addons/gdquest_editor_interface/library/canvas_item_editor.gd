@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_types.gd")


## The root node of the canvas item editor (main 2D view).
class CanvasItemEditorDef extends Types.Definition:
	func _init() -> void:
		node_type = "CanvasItemEditor"
		base_reference = Enums.NodePoint.MAIN_VIEW_CONTAINER_BOX

		resolver_steps = [
			Types.ChildTypeStep.new("CanvasItemEditor"),
		]


## The toolbar container of the canvas item editor.
class CanvasItemEditorToolbarDef extends Types.Definition:
	func _init() -> void:
		node_type = "Control"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR

		resolver_steps = [
			Types.ChildIndexStep.new(0),
			Types.ChildIndexStep.new(0),
			Types.ChildIndexStep.new(0),
		]


class CanvasItemEditorToolbarSelectButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 0)
		]


class CanvasItemEditorToolbarMoveButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 1)
		]


class CanvasItemEditorToolbarRotateButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 2)
		]


class CanvasItemEditorToolbarScaleButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 3)
		]


class CanvasItemEditorToolbarSelectableButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 4)
		]


class CanvasItemEditorToolbarPivotButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 5)
		]


class CanvasItemEditorToolbarPanButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 6)
		]


class CanvasItemEditorToolbarRulerButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 7)
		]


class CanvasItemEditorToolbarSmartSnapButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 8)
		]


class CanvasItemEditorToolbarGridButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 9)
		]


class CanvasItemEditorToolbarSnapOptionsButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 10)
		]


class CanvasItemEditorToolbarLockButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 11)
		]


class CanvasItemEditorToolbarUnlockButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 12)
		]


class CanvasItemEditorToolbarGroupButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 13)
		]


class CanvasItemEditorToolbarUngroupButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 14)
		]


class CanvasItemEditorToolbarSkeletonOptionsButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_TOOLBAR

		resolver_steps = [
			Types.ChildTypeStep.new("Button", 15)
		]
