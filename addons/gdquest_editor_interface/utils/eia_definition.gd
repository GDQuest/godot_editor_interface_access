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

		var section_keys := config.get_section_keys(section_name)
		if "custom_resolver" in section_keys:
			var step := CustomStep.new()
			step.script_code = String(config.get_value(section_name, "custom_resolver", "")).strip_edges()

			if step.script_code.is_empty():
				print("EIS: Resolver step '%s' is marked as custom but has no code." % [ section_name ])
				success = false
				continue

			resolver_steps.push_back(step)

	return success


# Step subtypes.

class Step:
	pass


class CustomStep extends Step:
	var script_code: String = ""
