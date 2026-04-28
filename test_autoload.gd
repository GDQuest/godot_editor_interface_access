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
