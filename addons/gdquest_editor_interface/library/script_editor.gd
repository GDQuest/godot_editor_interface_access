@tool

const Enums := preload("../utils/eia_enums.gd")
const Types := preload("../utils/eia_resolver_types.gd")
const Utils := preload("../utils/eia_resolver_utils.gd")


class ScriptEditorDef extends Types.Definition:
	func _init() -> void:
		node_type = "ScriptEditor"
		base_reference = Enums.NodePoint.MAIN_VIEW_CONTAINER_BOX

		resolver_steps = [
			Types.GetChildTypeStep.new("WindowWrapper", 0),
			Types.GetWindowWrappedTypeStep.new("ScriptEditor"),
		]


class ScriptEditorToolbarDef extends Types.Definition:
	func _init() -> void:
		node_type = "HBoxContainer"
		base_reference = Enums.NodePoint.SCRIPT_EDITOR

		resolver_steps = [
			Types.GetChildIndexStep.new(0), # Layout root.
			Types.GetChildTypeStep.new("HBoxContainer", 0),
		]


class ScriptEditorSidebarDef extends Types.Definition:
	func _init() -> void:
		node_type = "VSplitContainer"
		base_reference = Enums.NodePoint.SCRIPT_EDITOR

		resolver_steps = [
			Types.GetChildIndexStep.new(0), # Layout root.
			Types.GetChildTypeStep.new("HSplitContainer", 0),
			Types.GetChildTypeStep.new("VSplitContainer", 0),
		]


class ScriptEditorScriptListDef extends Types.Definition:
	func _init() -> void:
		node_type = "ItemList"
		base_reference = Enums.NodePoint.SCRIPT_EDITOR_SIDEBAR

		resolver_steps = [
			Types.GetChildTypeStep.new("VBoxContainer", 0),
			Types.GetChildTypeStep.new("ItemList"),
		]


class ScriptEditorScriptListFilterDef extends Types.Definition:
	func _init() -> void:
		node_type = "LineEdit"
		base_reference = Enums.NodePoint.SCRIPT_EDITOR_SIDEBAR

		resolver_steps = [
			Types.GetChildTypeStep.new("VBoxContainer", 0),
			Types.GetChildTypeStep.new("LineEdit"),
		]


class ScriptEditorCurrentScriptIndexDef extends Types.Definition:
	func _init() -> void:
		node_type = "ItemList"
		base_reference = Enums.NodePoint.SCRIPT_EDITOR_SIDEBAR

		resolver_steps = [
			Types.GetChildTypeStep.new("VBoxContainer", 1),
			Types.GetChildTypeStep.new("ItemList", 0),
		]


class ScriptEditorCurrentScriptIndexFilterDef extends Types.Definition:
	func _init() -> void:
		node_type = "LineEdit"
		base_reference = Enums.NodePoint.SCRIPT_EDITOR_SIDEBAR

		resolver_steps = [
			Types.GetChildTypeStep.new("VBoxContainer", 1),
			Types.GetChildTypeStep.new("HBoxContainer", 0),
			Types.GetChildTypeStep.new("LineEdit"),
		]


class ScriptEditorCurrentScriptIndexSortButtonDef extends Types.Definition:
	func _init() -> void:
		node_type = "Button"
		base_reference = Enums.NodePoint.SCRIPT_EDITOR_SIDEBAR

		resolver_steps = [
			Types.GetChildTypeStep.new("VBoxContainer", 1),
			Types.GetChildTypeStep.new("HBoxContainer", 0),
			Types.GetChildTypeStep.new("Button"),
		]


class ScriptEditorCurrentDocsIndexDef extends Types.Definition:
	func _init() -> void:
		node_type = "ItemList"
		base_reference = Enums.NodePoint.SCRIPT_EDITOR_SIDEBAR

		resolver_steps = [
			Types.GetChildTypeStep.new("VBoxContainer", 1),
			Types.GetChildTypeStep.new("ItemList", 1),
		]


class ScriptEditorContainerDef extends Types.Definition:
	func _init() -> void:
		node_type = "VBoxContainer"
		base_reference = Enums.NodePoint.SCRIPT_EDITOR

		resolver_steps = [
			Types.GetChildIndexStep.new(0), # Layout root.
			Types.GetChildTypeStep.new("HSplitContainer", 0),
			Types.GetChildTypeStep.new("VBoxContainer", 0),
		]


class ScriptEditorContainerTabsDef extends Types.Definition:
	func _init() -> void:
		node_type = "TabContainer"
		base_reference = Enums.NodePoint.SCRIPT_EDITOR_CONTAINER

		resolver_steps = [
			Types.GetChildTypeStep.new("TabContainer"),
		]


class ScriptEditorContainerFindReplaceBarDef extends Types.Definition:
	func _init() -> void:
		node_type = "FindReplaceBar"
		base_reference = Enums.NodePoint.SCRIPT_EDITOR_CONTAINER

		resolver_steps = [
			Types.GetChildTypeStep.new("FindReplaceBar"),
		]


# Reusable components.

class ScriptTextEditorCodeEditorDef extends Types.Definition:
	func _init() -> void:
		node_type = "CodeTextEditor"
		relative_node_type = "ScriptTextEditor"

		resolver_steps = [
			Types.GetChildTypeStep.new("VSplitContainer", 0),
			Types.GetChildTypeStep.new("CodeTextEditor"),
		]


class ScriptTextEditorCodeEditorCodeEditDef extends Types.Definition:
	func _init() -> void:
		node_type = "CodeEdit"
		relative_node_type = "ScriptTextEditor"

		resolver_steps = [
			Types.GetChildTypeStep.new("VSplitContainer", 0),
			Types.GetChildTypeStep.new("CodeTextEditor"),
			Types.GetChildTypeStep.new("CodeEdit"),
		]


class ScriptTextEditorCodeEditorFooterBarDef extends Types.Definition:
	func _init() -> void:
		node_type = "HBoxContainer"
		relative_node_type = "ScriptTextEditor"

		resolver_steps = [
			Types.GetChildTypeStep.new("VSplitContainer", 0),
			Types.GetChildTypeStep.new("CodeTextEditor"),
			Types.GetChildTypeStep.new("HBoxContainer", 0),
		]
