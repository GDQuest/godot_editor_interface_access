@tool

const Enums := preload("./eia_enums.gd")

### Definition sub-types ###

class Definition:
	# NOTE: Built-in types can be stored directly (as a GDScriptNativeClass
	# object), but that doesn't work for some valid types which are not exposed
	# to scripting, like CanvasItemEditor.
	var node_type: String = "Node"
	var base_reference: int = -1
	var resolver_steps: Array[Step] = []


# TODO: Add multi-definitions for resolving several nodes in one go.
#   - Pass an array of nodes in steps instead of just one.
#   - Define an array of node points that the definition returns, in order.
#   - For regular step types use them as a mapping function for each array element.
#   - Add a custom multi step with a callable that takes plural nodes and returns plural nodes.
#
# This should help with cases where multiple base locations are possible
# for the target node, as well as resolving toolbars and such, which is
# easier to do in one go (and nodes might depend on each other for heuristics).
#
# One multi-definition needs to be created for the entire bunch, but also
# sub-types that extend it (with no changes) for each target node must
# be added.


### Step sub-types. ###

class Step:
	pass


## Resolves a node using the passed callable. The callable must accept
## a node reference and return a node reference.
class CustomStep extends Step:
	var custom_callback: Callable = Callable()

	func _init(callback: Callable = Callable()) -> void:
		custom_callback = callback


## Finds a child node of the specified type. Optionally, can find the
## N-th child for the given type (only counting successful matches).
class ChildTypeStep extends Step:
	var type_name: String = ""
	var type_index: int = 0

	func _init(name: String = "", index: int = 0) -> void:
		type_name = name
		type_index = index


## Returns the N-th child node.
class ChildIndexStep extends Step:
	var child_index: int = 0

	func _init(index: int = 0) -> void:
		child_index = index


## Finds a descendant node of the specified type. Optionally, can find
## the N-th node for the given type (only counting successful matches).
class FindTypeStep extends Step:
	var type_name: String = ""
	var type_index: int = 0

	func _init(name: String = "", index: int = 0) -> void:
		type_name = name
		type_index = index


## Returns a descendant node according to the specified node path.
class NodePathStep extends Step:
	var node_path: NodePath = ""

	func _init(path: NodePath = "") -> void:
		node_path = path


## Returns the N-th parent node.
class ParentCountStep extends Step:
	var parent_count: int = 0

	func _init(count: int) -> void:
		parent_count = count


## Finds a node using previous node's signal and given child type.
class SignalCallableStep extends Step:
	var signal_name: String = ""
	var object_type_name: String = ""

	func _init(name: String = "", type: String = "") -> void:
		signal_name = name
		object_type_name = type
