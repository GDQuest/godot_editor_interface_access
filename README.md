# Editor Interface Access library for Godot

**Editor Interface Access** library tries its best to provide access to any
reasonably meaningful node in the editor node tree.

The Godot editor is built using the same building blocks as Godot projects,
which makes it extremely extensible in terms of UI/UX. Via the `EditorPlugin`
and `EditorInterface` API developers can already interact with many parts
that the engine team decided important enough for user intervention.

However, there are many more parts, which while having no API stability
guarantees can still be used to tune the editor experience to your needs.
This is where _Editor Interface Access_ comes in, with its vast library
of editor nodes that you can reference at a moment's notice!


## Compatibility

This library is compatible with **Godot 4.6.2**.

Compatibility with other Godot versions, even patch releases, cannot be guaranteed
due to the nature of this work. You should expect that:

* Within the same minor Godot release, e.g. any `4.6.x` version, most of the
  nodes will be accessible.

* Preceding and succeeding Godot releases will be partially compatible, with
  several nodes requiring updates to their resolution heuristics.

The project aims to maintain compatibility with the latest official stable
release of Godot. The last commit that supports any particular release is
tagged with the corresponding Godot version number in this repository.

_Note: **Editor Interface Access** is still in early stages of its life, and
changes are to be expected with time, as we better understand our own needs.
Your feedback and contributions are also welcome, though support that we may
be able to provide is limited. Please feel free to fork and adapt this library
to your needs!_


### Node coverage

**The coverage of editor nodes is not yet complete, and may never be fully
complete.** Nevertheless, there are many-many nodes that the library does make
available. Refer to the `NodePoint` enumeration provided (see usage examples
below).

The library also implements robust facilities for expansion. Every accessible
node is coded via a definition class, with various resolution helpers used.
Refer to the `/library` folder for further details.

_Note: Editor plugins can interfere with heuristics utilized by this library.
Editor Interface Access tries to rely on quick and stable fingerprints, but
everything with the editor tree can be modified to the degree where the library
can no longer locate the expected node. There is no way around it, so be aware!_


## Usage

Everything you need is provided via the single interface of the library.
To get started, load the `editor_interface_access.gd` from the addons folder.

```gdscript
var EIA := load("res://addons/gdquest_editor_interface/editor_interface_access.gd")
```

### Static editor nodes

After obtaining a library reference, use the `get_node()` method with one of
the `Enums.NodePoint` enumeration values to get a node reference.

```gdscript
var NodePoints := EIA.Enums.NodePoint
var button: Button = EIA.get_node(NodePoints.CANVAS_ITEM_EDITOR_MAIN_TOOLBAR_SELECTABLE_BUTTON)
```

By default, all node resolution results are cached and return results quickly
on subsequent calls. You can disable that behavior by setting the `skip_cache`
flag argument.

To find the node the library implements a number of semi-stable heurists which
work run-to-run. Engine changes, however, can always break them, as can user
plugins modifying the editor UI. Please report if some nodes cannot be resolved
in your case.


### Reusable editor components

Some editor nodes can be reused throughout its user interface, or can be
added and removed on the fly. For such cases where static resolution is not
possible exists the second key method, `get_node_relative()`.

Alongside the arguments that `get_node()` expects, this method also takes
a node reference as a point of context.

```gdscript
var NodePoints := EIA.Enums.NodePoint
var zoom_widget: Control = EIA.get_node(NodePoints.TILE_MAP_TILES_ATLAS_VIEW_ZOOM_WIDGET)
var zoom_reset: Button = EIA.get_node_relative(zoom_widget, NodePoints.EDITOR_ZOOM_WIDGET_RESET_BUTTON)
```


### Test suite

You can run the full test suite and check the library for errors in your editor
using the `test_resolve()` method. Some nodes, namely reusable ones, may require
you to set up the editor in a certain way (e.g. open a script file for editing).


## License

This project is provided under an [MIT license](LICENSE).
