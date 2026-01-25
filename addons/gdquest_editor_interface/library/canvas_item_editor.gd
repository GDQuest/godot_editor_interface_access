@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_resolver_types.gd")
const Utils := preload("../utils/eia_resolver_utils.gd")


## Root node of the canvas item editor (main 2D view).
class CanvasItemEditorDef extends Types.Definition:
	func _init() -> void:
		node_type = "CanvasItemEditor"
		base_reference = Enums.NodePoint.MAIN_VIEW_CONTAINER_BOX

		resolver_steps = [
			Types.GetChildTypeStep.new("CanvasItemEditor"),
		]


## Main toolbar container of the canvas item editor.
class CanvasItemEditorMainToolbarDef extends Types.Definition:
	func _init() -> void:
		node_type = "HBoxContainer"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR

		resolver_steps = [
			Types.GetChildTypeStep.new("MarginContainer", 0),
			Types.GetChildTypeStep.new("FlowContainer", 0),
			Types.GetChildTypeStep.new("HBoxContainer", 0),
		]


## All buttons preset in the toolbar, resolved together.
class CanvasItemEditorMainToolbarButtonsDef extends Types.MultiDefinition:
	func _init() -> void:
		node_type_map = {
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_SELECT_BUTTON:             "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_MOVE_BUTTON:               "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_ROTATE_BUTTON:             "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_SCALE_BUTTON:              "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_SELECTABLE_BUTTON:         "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_PIVOT_BUTTON:              "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_PAN_BUTTON:                "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_RULER_BUTTON:              "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_SMART_SNAP_BUTTON:         "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_GRID_BUTTON:               "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_SNAP_OPTIONS_BUTTON:       "MenuButton",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_LOCK_BUTTON:               "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_UNLOCK_BUTTON:             "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_GROUP_BUTTON:              "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_UNGROUP_BUTTON:            "Button",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_SKELETON_OPTIONS_BUTTON:   "MenuButton",
			Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_VIEW_OPTIONS_BUTTON:       "MenuButton",
		}
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR

		var custom_script := func(base_nodes: Array[Node]) -> Array[Node]:
			if base_nodes.is_empty():
				return []

			var results: Array[Node] = []
			results.resize(node_type_map.size())
			results.fill(null)

			var toolbar := base_nodes[0]
			var toolbar_buttons := toolbar.find_children("", "Button", false, false)
			results[0]  = toolbar_buttons[0]  if Utils.node_has_editor_icon(toolbar_buttons[0],  "ToolSelect", true)    else null
			results[1]  = toolbar_buttons[1]  if Utils.node_has_editor_icon(toolbar_buttons[1],  "ToolMove", true)      else null
			results[2]  = toolbar_buttons[2]  if Utils.node_has_editor_icon(toolbar_buttons[2],  "ToolRotate", true)    else null
			results[3]  = toolbar_buttons[3]  if Utils.node_has_editor_icon(toolbar_buttons[3],  "ToolScale", true)     else null
			results[4]  = toolbar_buttons[4]  if Utils.node_has_editor_icon(toolbar_buttons[4],  "ListSelect", true)    else null
			results[5]  = toolbar_buttons[5]  if Utils.node_has_editor_icon(toolbar_buttons[5],  "EditPivot", true)     else null
			results[6]  = toolbar_buttons[6]  if Utils.node_has_editor_icon(toolbar_buttons[6],  "ToolPan", true)       else null
			results[7]  = toolbar_buttons[7]  if Utils.node_has_editor_icon(toolbar_buttons[7],  "Ruler", true)         else null
			results[8]  = toolbar_buttons[8]  if Utils.node_has_editor_icon(toolbar_buttons[8],  "Snap", true)          else null
			results[9]  = toolbar_buttons[9]  if Utils.node_has_editor_icon(toolbar_buttons[9],  "SnapGrid", true)      else null
			results[10] = toolbar_buttons[10] if Utils.node_has_editor_icon(toolbar_buttons[10], "GuiTabMenuHl", true)  else null
			results[11] = toolbar_buttons[11] if Utils.node_has_editor_icon(toolbar_buttons[11], "Lock", true)          else null
			results[12] = toolbar_buttons[12] if Utils.node_has_editor_icon(toolbar_buttons[12], "Unlock", true)        else null
			results[13] = toolbar_buttons[13] if Utils.node_has_editor_icon(toolbar_buttons[13], "Group", true)         else null
			results[14] = toolbar_buttons[14] if Utils.node_has_editor_icon(toolbar_buttons[14], "Ungroup", true)       else null
			results[15] = toolbar_buttons[15] if Utils.node_has_editor_icon(toolbar_buttons[15], "Bone", true)          else null
			results[16] = toolbar_buttons[16]

			return results

		resolver_steps = [
			Types.DoCustomMultiStep.new(custom_script),
		]

class CanvasItemEditorMainToolbarSelectButtonDef            extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarMoveButtonDef              extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarRotateButtonDef            extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarScaleButtonDef             extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarSelectableButtonDef        extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarPivotButtonDef             extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarPanButtonDef               extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarRulerButtonDef             extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarSmartSnapButtonDef         extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarGridButtonDef              extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarSnapOptionsButtonDef       extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarLockButtonDef              extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarUnlockButtonDef            extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarGroupButtonDef             extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarUngroupButtonDef           extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarSkeletonOptionsButtonDef   extends CanvasItemEditorMainToolbarButtonsDef: pass
class CanvasItemEditorMainToolbarViewOptionsButtonDef       extends CanvasItemEditorMainToolbarButtonsDef: pass


## Toolbar container for contextual toolbars, populated by editor plugins.
class CanvasItemEditorContextualToolbarDef extends Types.Definition:
	func _init() -> void:
		node_type = "HBoxContainer"
		base_reference = Enums.NodePoint.CANVAS_ITEM_EDITOR

		resolver_steps = [
			Types.GetChildTypeStep.new("MarginContainer", 0),
			Types.GetChildTypeStep.new("FlowContainer", 0),
			Types.GetChildTypeStep.new("PanelContainer", 0),
			Types.GetChildIndexStep.new(0),
		]
