## Types used by the node point resolver utility. These server as base types
## for specific node point definitions and provide ready-made resolver steps
## used by said definitions.
@tool

const Enums := preload("./eia_enums.gd")

### Definition sub-types ###

## Standard definition that points to a single node through a series
## of resolver steps.
class Definition:
	# NOTE: Built-in types can be stored directly (as a GDScriptNativeClass
	# object), but that doesn't work for some valid types which are not exposed
	# to scripting, like CanvasItemEditor.

	## Expected node type of the last resolved node. Can be any valid ClassDB
	## type.
	var node_type: String = "Node"
	## Base node point value from which the resolver should start. Can be
	## -1 if no base reference is needed (then the first step must be a
	## custom one).
	var base_reference: int = -1
	## Node points which must be resolved before resolver can attempt to
	## go after the target node. Unlike the base reference, these are not
	## passed to the steps.
	var prefetch_references: Array[Enums.NodePoint] = []
	## Steps for the resolver to transform the base reference into the
	## target node or nodes.
	var resolver_steps: Array[Step] = []


## Multi-node definition that allows to resolve several nodes
## together in one go. Resolver steps operate on an array of nodes.
## The final step must return an array that maps exactly to the
## node_type_map property.
class MultiDefinition extends Definition:
	## Mapping between node point values and expected resulting node types.
	## Replaces the node_type property in multi-node definitions, and also
	## establishes the shape of the resulting array.
	var node_type_map: Dictionary[Enums.NodePoint, String] = {}


### Step sub-types. ###

class Step:
	# Resolver used by standard definitions.
	func resolve(_base_node: Node, step_index: int = 0) -> Node:
		push_warning("[EIA] Step %d: Resolver not implemented." % [ step_index ])
		return null

	# Resolver used by multi-node definitions.
	func resolve_multi(base_nodes: Array[Node], step_index: int = 0) -> Array[Node]:
		var results: Array[Node] = []
		for base_node in base_nodes:
			results.push_back(resolve(base_node, step_index))

		return results


## Resolves a node using the passed callable. The callable must accept
## a node reference and return a node reference.
class DoCustomStep extends Step:
	var custom_callback: Callable = Callable()

	func _init(callback: Callable) -> void:
		custom_callback = callback

	func resolve(base_node: Node, step_index: int = 0) -> Node:
		if not custom_callback.is_valid():
			push_error("[EIA] Step %d: Custom resolver has invalid callback." % [ step_index ])
			return null

		return custom_callback.call(base_node)


## Same as above, but for multi-node definitions. The callable must accept
## an array of node references and return a new array of node references.
class DoCustomMultiStep extends Step:
	var custom_callback: Callable = Callable()

	func _init(callback: Callable) -> void:
		custom_callback = callback

	func resolve_multi(base_nodes: Array[Node], step_index: int = 0) -> Array[Node]:
		if not custom_callback.is_valid():
			push_error("[EIA] Step %d: Custom multi-resolver has invalid callback." % [ step_index ])
			return []

		return custom_callback.call(base_nodes)


# Resolving steps turn node references into other node references.

## Finds a child node of the specified type. Optionally, can find the
## N-th child for the given type (only counting successful matches).
class GetChildTypeStep extends Step:
	var type_name: String = ""
	var type_index: int = 0

	func _init(name: String, index: int = 0) -> void:
		type_name = name
		type_index = index

	func resolve(base_node: Node, step_index: int = 0) -> Node:
		if not base_node:
			return null

		var counter := -1
		for child_node in base_node.get_children():
			if ClassDB.is_parent_class(child_node.get_class(), type_name):
				counter += 1
				if counter == type_index:
					return child_node

		push_error("[EIA] Step %d: Expected at least %d '%s' child node(s), found %d." % [ step_index, (type_index + 1), type_name, counter ])
		return null


## Returns the N-th child node.
class GetChildIndexStep extends Step:
	var child_index: int = 0

	func _init(index: int) -> void:
		child_index = index

	func resolve(base_node: Node, step_index: int = 0) -> Node:
		if not base_node:
			return null

		if base_node.get_child_count() <= child_index:
			push_error("[EIA] Step %d: Expected at least %d child node(s), found %d." % [ step_index, (child_index + 1), base_node.get_child_count() ])
			return null

		return base_node.get_child(child_index)


## Finds a descendant node of the specified type. Optionally, can find
## the N-th node for the given type (only counting successful matches).
class FindNodeTypeStep extends Step:
	var type_name: String = ""
	var type_index: int = 0

	func _init(name: String, index: int = 0) -> void:
		type_name = name
		type_index = index

	func resolve(base_node: Node, step_index: int = 0) -> Node:
		if not base_node:
			return null

		var found_nodes := base_node.find_children("", type_name, true, false)
		if found_nodes.size() <= type_index:
			push_error("[EIA] Step %d: Expected at least %d '%s' descendant node(s), found %d." % [ step_index, (type_index + 1), type_name, found_nodes.size() ])
			return null

		return found_nodes[type_index]


## Returns a descendant node according to the specified node path.
class GetNodePathStep extends Step:
	var node_path: NodePath = ""

	func _init(path: NodePath) -> void:
		node_path = path

	func resolve(base_node: Node, step_index: int = 0) -> Node:
		if not base_node:
			return null

		var fetched_node := base_node.get_node_or_null(node_path)
		if not fetched_node:
			push_error("[EIA] Step %d: Expected a node at path '%s'." % [ step_index, node_path ])
			return null

		return fetched_node


## Returns the N-th parent node.
class GetParentCountStep extends Step:
	var parent_count: int = 0

	func _init(count: int) -> void:
		parent_count = count

	func resolve(base_node: Node, step_index: int = 0) -> Node:
		if not base_node:
			return null

		var current_node: Node = base_node
		for i in parent_count:
			current_node = current_node.get_parent()
			if not current_node:
				push_error("[EIA] Step %d: Expected at least %d parent node(s), found %d." % [ step_index, parent_count, i ])
				return null

		return current_node


## Finds a node using previous node's signal and the specified
## connected object type.
class GetSignalTypeStep extends Step:
	var signal_name: String = ""
	var object_type_name: String = ""

	func _init(name: String, type: String) -> void:
		signal_name = name
		object_type_name = type

	func resolve(base_node: Node, step_index: int = 0) -> Node:
		if not base_node:
			return null

		var signal_ref: Signal = base_node[signal_name]
		if not signal_ref:
			push_error("[EIA] Step %d: Expected node to have signal '%s'." % [ step_index, signal_name ])
			return null

		for connection_info in signal_ref.get_connections():
			var object_ref := (connection_info["callable"] as Callable).get_object()

			if ClassDB.is_parent_class(object_ref.get_class(), object_type_name):
				return object_ref

		push_error("[EIA] Step %d: Expected '%s' node connected to signal '%s'." % [ step_index, object_type_name, signal_name ])
		return null


# Validating steps operate on the same node reference and return
# null if it doesn't satisfy the condition.

## Checks if the current node has the specified editor icon.
class HasEditorIconStep extends Step:
	var icon_name: String = ""

	func _init(name: String) -> void:
		icon_name = name

	func resolve(base_node: Node, step_index: int = 0) -> Node:
		if not base_node:
			return null

		var editor_theme := EditorInterface.get_editor_theme()
		if not editor_theme.has_icon(icon_name, "EditorIcons"):
			push_error("[EIA] Step %d: Icon '%s' not present in the editor theme." % [ step_index, icon_name ])
			return null

		var editor_icon := editor_theme.get_icon(icon_name, "EditorIcons")

		if base_node is Button:
			if base_node.icon != editor_icon:
				push_warning("[EIA] Step %d: Button expected to have icon '%s'." % [ step_index, icon_name ])
				return null
		else:
			push_warning("[EIA] Step %d: Node type '%s' not supported by editor icon resolver." % [ step_index, base_node.get_class() ])
			return null

		return base_node


## Checks if the current node has the specified callable connected
## to the specified signal.
class HasSignalCallableStep extends Step:
	var signal_name: String = ""
	var callable_name: String = ""

	func _init(name: String, callable: String) -> void:
		signal_name = name
		callable_name = callable

	func resolve(base_node: Node, step_index: int = 0) -> Node:
		if not base_node:
			return null

		var signal_ref: Signal = base_node[signal_name]
		if not signal_ref:
			push_error("[EIA] Step %d: Expected node to have signal '%s'." % [ step_index, signal_name ])
			return null

		for connection_info in signal_ref.get_connections():
			var method_name := (connection_info["callable"] as Callable).get_method()

			if method_name == callable_name:
				return base_node

		push_error("[EIA] Step %d: Expected callable '%s' connected to signal '%s'." % [ step_index, callable_name, signal_name ])
		return null
