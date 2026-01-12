@tool

const Enums := preload("./eia_enums.gd")

var description: String = ""

var node_type: String = ""

var base_reference_group: String = ""
var base_reference_key: String = ""
var base_reference_point: int = -1 # One of node point enum values, or -1 if empty.

var resolver_steps: Array[Step] = []


func parse(config: ConfigFile) -> bool:
	description = String(config.get_value("", "description", "")).strip_edges()
	node_type = String(config.get_value("", "node_type", "")).strip_edges()
	if node_type.is_empty():
		print("EIA: Definition node type cannot be empty.")
		return false
	if not ClassDB.class_exists(node_type):
		print("EIA: Definition node type '%s' is not a valid type." % [ node_type ])
		return false

	var base_reference_name := String(config.get_value("", "base_reference", "")).strip_edges()
	if base_reference_name.is_empty():
		base_reference_group = ""
		base_reference_key = ""
		base_reference_point = -1
	else:
		var base_reference_parts := base_reference_name.split(".")
		if base_reference_parts.size() != 2 || base_reference_parts[0].is_empty() || base_reference_parts[1].is_empty():
			print("EIA: Definition base reference '%s' is invalid." % [ base_reference_name ])
			return false

		var enum_name := base_reference_parts[0]
		var enum_key := base_reference_parts[1]

		if enum_name not in Enums:
			print("EIA: Definition base reference '%s' has invalid enum name (%s)." % [ base_reference_name, enum_name ])
			return false

		var enum_data: Dictionary = Enums[enum_name]
		if not enum_data.has(enum_key):
			print("EIA: Definition base reference '%s' has invalid enum value (%s)." % [ base_reference_name, enum_key ])
			return false

		base_reference_group = enum_name
		base_reference_key = enum_key
		base_reference_point = enum_data[enum_key]

	resolver_steps.clear()
	if not _parse_steps(config):
		return false

	return true


func _parse_steps(config: ConfigFile) -> bool:
	var success := true

	for section_name in config.get_sections():
		if not section_name.begins_with("resolver_step"):
			continue

		# Sub-type determination is based on what properties are available.
		# First match wins.
		var section_keys := config.get_section_keys(section_name)
		var step: Step = null

		if "custom_resolver" in section_keys:
			step = CustomStep.new()
			step.script_code = String(config.get_value(section_name, "custom_resolver", "")).strip_edges()

			if step.script_code.is_empty():
				print("EIS: Resolver step '%s' (custom) has no code." % [ section_name ])
				success = false
				continue

		elif "type_name" in section_keys:
			step = TypeStep.new()
			step.type_name = String(config.get_value(section_name, "type_name", "")).strip_edges()
			step.type_index = config.get_value(section_name, "type_index", 0)

			if step.type_index < 0:
				step.type_index = 0

			if not ClassDB.class_exists(step.type_name):
				print("EIS: Resolver step '%s' (type) has invalid type name (%s)." % [ section_name, step.type_name ])
				success = false
				continue

		elif "child_index" in section_keys:
			step = IndexStep.new()
			step.child_index = config.get_value(section_name, "child_index", 0)

			if step.child_index < 0:
				step.child_index = 0

		step.step_key = section_name
		resolver_steps.push_back(step)

	return success


# Step sub-types.

class Step:
	var step_key: String = ""


class CustomStep extends Step:
	var script_code: String = ""


class TypeStep extends Step:
	var type_name: String = ""
	var type_index: int = 0


class IndexStep extends Step:
	var child_index: int = 0
