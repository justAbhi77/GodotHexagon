extends Node2D

class_name UI

@onready var _TileAsset: = preload("res://Scenes/CustTile.tscn")
@onready var _Tilemap:TileMap = get_node("/root/World/TileMap")

func _ready():
	position = _Tilemap.position
	
	var grid = _Tilemap.get_used_cells(0)	
	for i in grid:
		var tile: = _TileAsset.instantiate()
		add_child(tile)
		tile.position = _Tilemap.map_to_local(i)
		tile.position -= Vector2(64,74)
		await get_tree().create_timer(0.05).timeout
		
	#for child in get_children():
		#child.position = _Tilemap.map_to_local(Vector2i(0,1))
		#child.position -= Vector2(64,74)

func _on_button_pressed():
	var global_mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var pos_clicked: Vector2i = _Tilemap.local_to_map(global_mouse_pos)
	print("Mouse Clicked on UI at pos ", pos_clicked)
