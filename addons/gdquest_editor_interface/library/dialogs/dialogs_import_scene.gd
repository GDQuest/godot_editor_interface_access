@tool

const Enums := preload("../../utils/eia_enums.gd")
const Types := preload("../../utils/eia_resolver_types.gd")


class ImportSceneSettingsDialogDef extends Types.Definition:
	func _init() -> void:
		node_type = "SceneImportSettingsDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("SceneImportSettingsDialog")
		]
