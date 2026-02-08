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
