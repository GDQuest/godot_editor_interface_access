@tool

const Enums := preload("../utils/eia_enums.gd")
const Definition := preload("../utils/eia_definition.gd")


class EditorSettingsDialogDef extends Definition:
	func _init() -> void:
		node_type = "EditorSettingsDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("EditorSettingsDialog")
		]


class ProjectSettingsDialogDef extends Definition:
	func _init() -> void:
		node_type = "ProjectSettingsEditor"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("ProjectSettingsEditor")
		]


class ProjectExportDialogDef extends Definition:
	func _init() -> void:
		node_type = "ProjectExportDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("ProjectExportDialog")
		]


class ExportTemplateManagerDef extends Definition:
	func _init() -> void:
		node_type = "ExportTemplateManager"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("ExportTemplateManager")
		]


class FeatureProfileManagerDef extends Definition:
	func _init() -> void:
		node_type = "EditorFeatureProfileManager"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("EditorFeatureProfileManager")
		]


class BuildProfileManagerDef extends Definition:
	func _init() -> void:
		node_type = "EditorBuildProfileManager"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("EditorBuildProfileManager")
		]


class EditorAboutDialogDef extends Definition:
	func _init() -> void:
		node_type = "EditorAbout"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("EditorAbout")
		]


class OrphanResourcesDialogDef extends Definition:
	func _init() -> void:
		node_type = "OrphanResourcesDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("OrphanResourcesDialog")
		]


class DependencyEditorDialogDef extends Definition:
	func _init() -> void:
		node_type = "DependencyEditor"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("DependencyEditor")
		]


class DependencyErrorDialogDef extends Definition:
	func _init() -> void:
		node_type = "DependencyErrorDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("DependencyErrorDialog")
		]


class ImportSceneSettingsDialogDef extends Definition:
	func _init() -> void:
		node_type = "SceneImportSettingsDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("SceneImportSettingsDialog")
		]


class ImportAudioStreamSettingsDialogDef extends Definition:
	func _init() -> void:
		node_type = "AudioStreamImportSettingsDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("AudioStreamImportSettingsDialog")
		]


class ImportDynamicFontSettingsDialogDef extends Definition:
	func _init() -> void:
		node_type = "DynamicFontImportSettingsDialog"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("DynamicFontImportSettingsDialog")
		]


## NOTE: Not available in Android and Web builds.
class FbxImporterManagerDef extends Definition:
	func _init() -> void:
		node_type = "FBXImporterManager"
		base_reference = Enums.NodePoint.LAYOUT_ROOT

		resolver_steps = [
			Definition.ChildTypeStep.new("FBXImporterManager")
		]
