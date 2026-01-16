@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


class InspectorDockInspectorDef extends Definition:
	func _init() -> void:
		node_type = "EditorInspector"

		var custom_script := """
EditorInterface.get_inspector()
"""
		resolver_steps = [
			Definition.CustomStep.new(custom_script),
		]


class InspectorDockInspectorBeginBoxDef extends Definition:
	func _init() -> void:
		node_type = "VBoxContainer"
		base_reference = Enums.NodePoint.INSPECTOR_DOCK_INSPECTOR

		resolver_steps = [
			Definition.ChildIndexStep.new(0),
			Definition.ChildTypeStep.new("VBoxContainer", 0)
		]


class InspectorDockInspectorFavoritesDef extends Definition:
	func _init() -> void:
		node_type = "VBoxContainer"
		base_reference = Enums.NodePoint.INSPECTOR_DOCK_INSPECTOR

		resolver_steps = [
			Definition.ChildIndexStep.new(0),
			Definition.ChildTypeStep.new("VBoxContainer", 1)
		]


class InspectorDockInspectorPropertiesDef extends Definition:
	func _init() -> void:
		node_type = "VBoxContainer"
		base_reference = Enums.NodePoint.INSPECTOR_DOCK_INSPECTOR

		resolver_steps = [
			Definition.ChildIndexStep.new(0),
			Definition.ChildTypeStep.new("VBoxContainer", 2)
		]
