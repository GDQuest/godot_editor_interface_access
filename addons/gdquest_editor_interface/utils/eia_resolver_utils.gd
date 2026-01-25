## Utility functions for the node point resolver utility and point definitions.
@tool


static func _check_node_signal_callable(base_node: Node, signal_name: String, callable_name: String, strict: bool = false) -> bool:
	var signal_ref: Signal = base_node[signal_name]
	if not signal_ref:
		if strict:
			push_warning("[EIA] Expected signal '%s' on node %s." % [ signal_name, base_node ])
		return false

	var signal_connections := signal_ref.get_connections()
	for connect_info: Dictionary in signal_connections:
		var callable := connect_info["callable"] as Callable
		if not callable || not callable.is_valid():
			continue

		if callable.get_method() == callable_name:
			return true

	return false


static func node_has_signal_callable(base_node: Node, signal_name: String, callable_name: String, strict: bool = false) -> bool:
	if _check_node_signal_callable(base_node, signal_name, callable_name):
		return true

	if strict:
		push_warning("[EIA] Expected callable '%s' connected to signal '%s' on node %s." % [ callable_name, signal_name, base_node ])
	return false


static func node_has_any_signal_callable(base_node: Node, callable_name: String, strict: bool = false) -> bool:
	for signal_info: Dictionary in base_node.get_signal_list():
		if _check_node_signal_callable(base_node, signal_info.name, callable_name):
			return true

	if strict:
		push_warning("[EIA] Expected callable '%s' connected to any signal on node %s." % [ callable_name, base_node ])
	return false


static func node_has_editor_icon(base_node: Node, icon_name: String, strict: bool = false) -> bool:
	var editor_theme := EditorInterface.get_editor_theme()
	if not editor_theme.has_icon(icon_name, "EditorIcons"):
		if strict:
			push_warning("[EIA] Icon '%s' not present in the editor theme." % [ icon_name ])
		return false

	var editor_icon := editor_theme.get_icon(icon_name, "EditorIcons")

	if base_node is Button:
		if base_node.icon != editor_icon:
			if strict:
				push_warning("[EIA] Expected icon '%s' on Button node." % [ icon_name ])
			return false
	else:
		if strict:
			push_warning("[EIA] Node type '%s' not supported by editor icon checker." % [ base_node.get_class() ])
		return false

	return true
