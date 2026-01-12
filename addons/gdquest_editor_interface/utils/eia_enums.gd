## Enums used by the editor interface access system.
@tool

# Node point enums are split into meaningful major groups to
# make it easier to manage them. Values are enumerated continuously
# and should not conflict between enums. Sufficient padding is
# given to ensure that.

enum NPGeneral { # 0
	# Core/root nodes.
	EDITOR_MAIN_WINDOW = 1,
	EDITOR_NODE = 100,
	EDITOR_BASE_CONTROL = 1000,

	# Editor menu bar.
	MENU_BAR = 1100,

	# Main context/screen view.
	MAIN_CONTEXT_SWITCHER = 1200,
	MAIN_CONTEXT_SWITCHER_2D_BUTTON,
	MAIN_CONTEXT_SWITCHER_3D_BUTTON,
	MAIN_CONTEXT_SWITCHER_SCRIPT_BUTTON,
	MAIN_CONTEXT_SWITCHER_GAME_BUTTON,
	MAIN_CONTEXT_SWITCHER_ASSET_LIB_BUTTON,
	MAIN_CONTEXT_CONTAINER = 1300,

	# Editor run bar.
	RUN_BAR = 1400,
	RUN_BAR_PLAY_BUTTON,
	RUN_BAR_PAUSE_BUTTON,
	RUN_BAR_STOP_BUTTON,
	RUN_BAR_PLAY_CURRENT_BUTTON,
	RUN_BAR_PLAY_CUSTOM_BUTTON,
	RUN_BAR_MOVIE_MODE_BUTTON,

	# Scene tabs.
	SCENE_TAB_BAR = 1500,
	SCENE_TAB_BAR_ADD_BUTTON,

	# Misc.
	RENDERING_MODE_SWITCHER = 10_000,
	DISTRACTION_FREE_BUTTON,
}

enum NPDialogs { # 100_000

}

enum NPDocks { # 200_000

}

enum NPCanvasEditor { # 1_000_000

}

enum NPSpatialEditor { # 2_000_000

}

enum NPScriptEditor { # 3_000_000

}

enum NPGameView { # 4_000_000

}

enum NPAssetLibrary { # 5_000_000

}


# Utilities.

static var _enum_map := {}


## Reflection method that returns the enum value key for the given enum and value.
static func get_enum_key(enum_type: Dictionary, enum_value: int) -> String:
	var enum_key := enum_type.find_key(enum_value)
	if not enum_key:
		return ""

	return String(enum_key)


## Reflection method that returns the enum name for the given enum.
static func get_enum_name(enum_type: Dictionary) -> String:
	if _enum_map.is_empty():
		_enum_map = new().get_script().get_script_constant_map()

	var enum_name := _enum_map.find_key(enum_type)
	return String(enum_name)
