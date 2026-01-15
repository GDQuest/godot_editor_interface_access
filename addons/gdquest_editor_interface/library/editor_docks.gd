@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


class FileSystemDockDef extends Definition:
	func _init() -> void:
		node_type = "FileSystemDock"
		base_reference = Enums.NodePoint.EDITOR_FILE_SYSTEM

		resolver_steps = [
			Definition.SignalCallableStep.new("filesystem_changed", "FileSystemDock"),
		]


class HistoryDockDef extends Definition:
	func _init() -> void:
		node_type = "HistoryDock"
		base_reference = Enums.NodePoint.EDITOR_NODE

		resolver_steps = [
			Definition.SignalCallableStep.new("scene_changed", "HistoryDock"),
		]


class InspectorDockDef extends Definition:
	func _init() -> void:
		node_type = "InspectorDock"
		base_reference = Enums.NodePoint.FILE_SYSTEM_DOCK

		resolver_steps = [
			Definition.SignalCallableStep.new("files_moved", "InspectorDock"),
		]
