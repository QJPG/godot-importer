@tool
extends EditorPlugin

var context := ImporterEditorContextMenuPlugin.new()

func _enter_tree() -> void:
	add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_FILESYSTEM, context)
	pass

func _exit_tree() -> void:
	remove_context_menu_plugin(context)
	pass
