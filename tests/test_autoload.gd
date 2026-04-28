## A dev-only autoload that makes testing EditorInterfaceAccess a little
## more convenient. It is registered as EIATest, and can be accessed within
## this project by tool scripts and plugins.
##
## [b]Warning:[/b] This file should not be included with the library distribution!
## If you have this file in your project, it is safe to delete.

@tool
extends Node

const Access := preload("res://addons/gdquest_editor_interface/editor_interface_access.gd")
const NodePoints := Access.Enums.NodePoint


func run_resolve_test() -> void:
	# First, reset the editor for the test.
	# Open script editor on these resources so dynamic nodes can be resolved.

	# Help page.
	EditorInterface.get_script_editor().goto_help("class_name:Node")
	await get_tree().process_frame
	# JSON document (plain text cannot be loaded as a resource directly).
	EditorInterface.edit_resource(load("res://tests/data/test_json.json"))
	await get_tree().process_frame
	# Script file.
	EditorInterface.edit_script(load("res://tests/data/test_script.gd"))
	await get_tree().process_frame

	# Run the test.
	Access.test_resolve()

	# Generate a report.

	var godot_version := Engine.get_version_info()
	var datetime_string := Time.get_datetime_string_from_system(true).replace(":", "").replace("-", "")
	var test_report_path := "res://tests/reports/report_%s.%s.%s_%s_%s.txt" % [
		godot_version["major"],
		godot_version["minor"],
		godot_version["patch"],
		godot_version["status"],
		datetime_string,
	]
	var test_report := PackedStringArray()

	for node_key: String in NodePoints:
		var node_point: int = NodePoints[node_key]
		var node_ref: Node = null

		# Relative nodes need context, so we piggyback off of test subroutines.
		if Access.Resolver.is_node_relative(node_point):
			node_ref = Access._test_resolve_relative(node_point, false)
		else:
			node_ref = Access.Resolver.get_node_cached(node_point)

		test_report.push_back(node_key)
		if not node_ref:
			test_report.push_back("! ERROR: Node has failed to resolve and is missing.")
			continue

		test_report.push_back("- %s <%s> [%d]" % [ node_ref.name, node_ref.get_class(), node_ref.get_index(true) ])
		test_report.push_back("- %s" % [ node_ref.get_path() ])

		var typed_path := PackedStringArray()
		var typed_ref := node_ref
		while typed_ref:
			typed_path.push_back("%s[%d]" % [ typed_ref.get_class(), typed_ref.get_index(true) ])
			typed_ref = typed_ref.get_parent()

		typed_path.reverse()
		test_report.push_back("- %s" % [ "/".join(typed_path) ])

	var fs := DirAccess.open("res://")
	if not fs.dir_exists(test_report_path.get_base_dir()):
		fs.make_dir_recursive(test_report_path.get_base_dir())

	var test_report_file := FileAccess.open(test_report_path, FileAccess.WRITE)
	if test_report_file:
		test_report_file.store_string("\n".join(test_report))
		print("Test report written to %s" % [ test_report_path ])
