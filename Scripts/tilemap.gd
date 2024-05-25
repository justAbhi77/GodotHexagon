extends TileMap

class_name tilemap

func _input(_event):
	if _event is InputEventMouseButton and _event.button_index == MOUSE_BUTTON_LEFT and _event.is_pressed():
		var global_mouse_pos: Vector2 = _event.position
		var pos_clicked := local_to_map(to_local(global_mouse_pos))
		print("Mouse Clicked at pos ", pos_clicked)
		var tile_data := get_cell_tile_data(0, pos_clicked)
		var local_data: testdataClass = tile_data.get_custom_data("LocalData")
		var custom_data: testdataClass = tile_data.get_custom_data("CustomClass")
		if local_data:
			print("Found local data at ", pos_clicked, " which is ", local_data._to_string())
			local_data.change_value(local_data.vartestdata + 1, local_data.testsmth + Vector2.ONE)
			tile_data.set_custom_data("LocalData", local_data)
		else:
			if custom_data:
				print("Found custom data at ", pos_clicked, " which is ", custom_data._to_string())
				var newtestdataClass: testdataClass = testdataClass.new()
				newtestdataClass.copy_from_obj(custom_data)
				tile_data.set_custom_data("LocalData", newtestdataClass)