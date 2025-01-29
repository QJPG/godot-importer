extends EditorContextMenuPlugin

class_name ImporterEditorContextMenuPlugin

func copy_to(from : String, destiny : String) -> void:
	var fnames := from.split("/")
	var f := FileAccess.open(destiny + fnames[fnames.size() - 1], FileAccess.WRITE)
	
	if not f.store_buffer(FileAccess.get_file_as_bytes(from)):
		OS.alert("Error on write file! (%s)" % from)
	f.close()
	
	EditorInterface.get_resource_filesystem().scan()
	EditorInterface.get_resource_filesystem().scan_sources()
	
	pass

func _import(paths : Array) -> void:
	var fs := FileDialog.new()
	fs.use_native_dialog = true
	fs.access = FileDialog.ACCESS_FILESYSTEM
	fs.file_mode = FileDialog.FILE_MODE_OPEN_FILES
	fs.title = "Import File(s)"
	fs.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	fs.files_selected.connect(func(files : PackedStringArray) -> void:
		for fname in files:
			for dname in paths:
				copy_to(fname, ProjectSettings.globalize_path(dname))
		fs.queue_free()
		return)
	Engine.get_main_loop().root.add_child(fs)
	fs.show()
	
	return

func _popup_menu(paths: PackedStringArray) -> void:
	add_context_menu_item("Import Files Here", _import, preload("res://addons/AImporter/import-icon.svg"))
