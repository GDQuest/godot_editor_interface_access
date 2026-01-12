## Editor interface access is a system for serializing, referencing, and retrieving
## editor GUI elements with persistent identifiers.
@tool

const Enums := preload("./utils/eia_enums.gd")
const Resolver := preload("./utils/eia_resolver.gd")


## Resolves and returns a node in the editor tree associated with the
## given enum value. Returns null if node cannot be resolved.
## Resolved node is cached for future calls.
static func get_node_static(node_enum: Dictionary, node_point: int) -> Node:
	var enum_name := Enums.get_enum_name(node_enum)
	var enum_key := Enums.get_enum_key(node_enum, node_point)

	return Resolver.resolve(enum_name, enum_key, node_point)


## Analogous to get_node_static(), but does not retrieve from or write to
## the node cache.
static func get_node_dynamic(node_enum: Dictionary, node_point: int) -> Node:
	var enum_name := Enums.get_enum_name(node_enum)
	var enum_key := Enums.get_enum_key(node_enum, node_point)

	return Resolver.resolve(enum_name, enum_key, node_point, true)
