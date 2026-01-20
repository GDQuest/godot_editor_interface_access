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
