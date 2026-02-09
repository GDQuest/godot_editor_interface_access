@tool

const Enums := preload("../../utils/eia_enums.gd")
const Types := preload("../../utils/eia_resolver_types.gd")
const Utils := preload("../../utils/eia_resolver_utils.gd")


## Root node of the node 3D (a.k.a. spatial) editor (main 3D view).
class Node3dEditorDef extends Types.Definition:
	func _init() -> void:
		node_type = "Node3DEditor"
		base_reference = Enums.NodePoint.MAIN_VIEW_CONTAINER_BOX

		resolver_steps = [
			Types.GetChildTypeStep.new("Node3DEditor"),
		]


## Main toolbar container of the node 3D editor.
class Node3dEditorMainToolbarDef extends Types.Definition:
	func _init() -> void:
		node_type = "HBoxContainer"
		base_reference = Enums.NodePoint.NODE_3D_EDITOR

		resolver_steps = [
			Types.GetChildTypeStep.new("MarginContainer", 0),
			Types.GetChildTypeStep.new("FlowContainer", 0),
			Types.GetChildTypeStep.new("HBoxContainer", 0),
		]


## Toolbar container for contextual toolbars, populated by editor plugins.
class Node3dEditorContextualToolbarsDef extends Types.Definition:
	func _init() -> void:
		node_type = "HBoxContainer"
		base_reference = Enums.NodePoint.NODE_3D_EDITOR

		resolver_steps = [
			Types.GetChildTypeStep.new("MarginContainer", 0),
			Types.GetChildTypeStep.new("FlowContainer", 0),
			Types.GetChildTypeStep.new("PanelContainer", 0),
			Types.GetChildIndexStep.new(0),
		]


# Viewports.

class Node3dEditorViewportsDef extends Types.Definition:
	func _init() -> void:
		node_type = "Node3DEditorViewportContainer"
		base_reference = Enums.NodePoint.NODE_3D_EDITOR

		# NOTE: These split containers are not what is responsible for
		# different viewport layout compositions. The Node3DEditorViewportContainer
		# is. Split containers exist for plugins to add sidebars, like
		# the original GridMap plugin's dock.

		resolver_steps = [
			Types.GetChildTypeStep.new("SplitContainer", 0),
			Types.GetChildTypeStep.new("SplitContainer", 0),
			Types.GetChildTypeStep.new("SplitContainer", 0),
			Types.GetChildTypeStep.new("Node3DEditorViewportContainer"),
		]


# There are exactly 4 viewports in the node 3D editor at this time.
# This may or may not change, but since they are identical, we define
# them as reusable components.

# NOTE: The order of viewport nodes does not necessarily map to what
# is made visible by layouts first. I.e. layouts with only 2 viewports
# side by side do not necessarily make viewports 1 and 2 visible.

class Node3dEditorViewportSceneRootDef extends Types.Definition:
	func _init() -> void:
		node_type = "SubViewport"
		relative_node_type = "Node3DEditorViewport"

		resolver_steps = [
			Types.GetChildTypeStep.new("SubViewportContainer"),
			Types.GetChildTypeStep.new("SubViewport"),
		]


class Node3dEditorViewportOverlaysDef extends Types.Definition:
	func _init() -> void:
		node_type = "Control"
		relative_node_type = "Node3DEditorViewport"

		resolver_steps = [
			Types.GetChildTypeStep.new("Control", 1),
		]
