@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_resolver_types.gd")


class EditorSettingsDialogDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorSettingsDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("EditorSettingsDialog")
		]


class ProjectSettingsDialogDef extends Types.Definition:
	func _init() -> void:
		node_type = "ProjectSettingsEditor"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("ProjectSettingsEditor")
		]


class ProjectExportDialogDef extends Types.Definition:
	func _init() -> void:
		node_type = "ProjectExportDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("ProjectExportDialog")
		]


class ExportTemplateManagerDef extends Types.Definition:
	func _init() -> void:
		node_type = "ExportTemplateManager"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("ExportTemplateManager")
		]


class FeatureProfileManagerDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorFeatureProfileManager"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("EditorFeatureProfileManager")
		]


class BuildProfileManagerDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorBuildProfileManager"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("EditorBuildProfileManager")
		]


class EditorAboutDialogDef extends Types.Definition:
	func _init() -> void:
		node_type = "EditorAbout"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("EditorAbout")
		]


class OrphanResourcesDialogDef extends Types.Definition:
	func _init() -> void:
		node_type = "OrphanResourcesDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("OrphanResourcesDialog")
		]


class DependencyEditorDialogDef extends Types.Definition:
	func _init() -> void:
		node_type = "DependencyEditor"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("DependencyEditor")
		]


class DependencyErrorDialogDef extends Types.Definition:
	func _init() -> void:
		node_type = "DependencyErrorDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("DependencyErrorDialog")
		]


class ImportSceneSettingsDialogDef extends Types.Definition:
	func _init() -> void:
		node_type = "SceneImportSettingsDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("SceneImportSettingsDialog")
		]


class ImportAudioStreamSettingsDialogDef extends Types.Definition:
	func _init() -> void:
		node_type = "AudioStreamImportSettingsDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("AudioStreamImportSettingsDialog")
		]


class ImportDynamicFontSettingsDialogDef extends Types.Definition:
	func _init() -> void:
		node_type = "DynamicFontImportSettingsDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("DynamicFontImportSettingsDialog")
		]


## NOTE: Not available in Android and Web builds.
class FbxImporterManagerDef extends Types.Definition:
	func _init() -> void:
		node_type = "FBXImporterManager"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Types.GetChildTypeStep.new("FBXImporterManager")
		]
