@tool

const Enums := preload("./eia_enums.gd")

# Definition properties.

# NOTE: Built-in types can be stored directly (as a GDScriptNativeClass
# object), but that doesn't work for some valid types which are not exposed
# to scripting, like CanvasItemEditor.
var node_type: String = "Node"
var base_reference: int = -1
var resolver_steps: Array[Step] = []


# Step sub-types.

class Step:
	pass


class CustomStep extends Step:
	var script_code: String = ""

	func _init(code: String = "") -> void:
		script_code = code.strip_edges()


class ChildTypeStep extends Step:
	var type_name: String = ""
	var type_index: int = 0

	func _init(name: String = "", index: int = 0) -> void:
		type_name = name
		type_index = index


class ChildIndexStep extends Step:
	var child_index: int = 0

	func _init(index: int = 0) -> void:
		child_index = index


class SignalCallableStep extends Step:
	var signal_name: String = ""
	var object_type_name: String = ""

	func _init(name: String = "", type: String = "") -> void:
		signal_name = name
		object_type_name = type
