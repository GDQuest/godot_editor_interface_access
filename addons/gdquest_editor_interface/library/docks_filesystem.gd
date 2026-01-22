@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_types.gd")


class FileSystemDockDef extends Types.Definition:
	func _init() -> void:
		node_type = "FileSystemDock"
		base_reference = Enums.NodePoint.EDITOR_FILE_SYSTEM

		resolver_steps = [
			Types.SignalCallableStep.new("filesystem_changed", "FileSystemDock"),
		]
