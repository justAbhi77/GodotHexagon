class_name UI extends Node2D

@onready var _TileAsset: = preload("res://Scenes/CustTile.tscn")
@onready var _DesertAsset: = preload("res://Images/Tiles/Desert/Desert.png")
@onready var _BricksAsset: = [preload("res://Images/Tiles/Brick/Brick_1.png"), preload("res://Images/Tiles/Brick/Brick_2.png"), preload("res://Images/Tiles/Brick/Brick_3.png")]
@onready var _ForestsAsset: = [preload("res://Images/Tiles/Forest/Forest_1.png"), preload("res://Images/Tiles/Forest/Forest_2.png"), preload("res://Images/Tiles/Forest/Forest_3.png"), preload("res://Images/Tiles/Forest/Forest_4.png")]
@onready var _MountainAsset: = preload("res://Images/Tiles/Mountain/Mountain.png")
@onready var _FarmAsset: = preload("res://Images/Tiles/Farm/Farm.png")
@onready var _GrasslandAsset: = preload("res://Images/Tiles/Grassland/Grassland.png")
@onready var _Tilemap:TileMap = get_node("/root/World/TileMap")

var Tiles = []

func _ready():
	position = _Tilemap.position
	
	var index = 0
	var WorldTileTypes = []
	for x in Enums.TileType.values():
		print(typeof(x))
		var countTiles = Enums.EWorldTileCount[index]
		for y in range(countTiles):
			WorldTileTypes.append(x)
		index += 1
	WorldTileTypes.shuffle()
	index = 0
	
	var grid = _Tilemap.get_used_cells(0)
	grid.sort()
	
	var lasttile = grid[-1]
	var Maxlasttile = max(lasttile.x,lasttile.y) + 1
	
	for i in Maxlasttile:
		var empty = []
		empty.resize(Maxlasttile)
		Tiles.append(empty)
		
	for i in grid:
		var tile : CustTile = _TileAsset.instantiate()
		Tiles[i.x][i.y] = tile
		tile.tileX = i.x
		tile.tileY = i.y
		add_child(tile)
		tile.position = _Tilemap.map_to_local(i)
		tile.position -= Vector2(64,74)
		setup_tile_properties(tile,WorldTileTypes[index])
		index += 1
		tile.EdgeClicked.connect(On_Edge_Clicked)
		tile.VertexClicked.connect(On_Vertex_Clicked)
		await get_tree().create_timer(0.05).timeout
		
	print("hello")
	#for child in get_children():
		#child.position = _Tilemap.map_to_local(Vector2i(0,1))
		#child.position -= Vector2(64,74)

func _on_button_pressed():
	var global_mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var pos_clicked: Vector2i = _Tilemap.local_to_map(global_mouse_pos)
	print("Mouse Clicked on UI at pos ", pos_clicked)

func setup_tile_properties(tile:CustTile ,tiletype:Enums.TileType):
	tile.LabelText.text = str(tile.tileX, ", ",tile.tileY)
	match tiletype:
		Enums.TileType.Desert:
			tile.name = "Desert"
			tile.TileImage.set_texture(_DesertAsset)
			tile.Resources = Enums.TileResources.NIL
		Enums.TileType.Brick:
			tile.name = "Brick"
			tile.TileImage.set_texture(_BricksAsset.pick_random())
			tile.Resources = Enums.TileResources.Bricks
		Enums.TileType.Forest:
			tile.name = "Forest"
			tile.TileImage.set_texture(_ForestsAsset.pick_random())
			tile.Resources = Enums.TileResources.Wood
		Enums.TileType.Mountains:
			tile.name = "Mountains"
			tile.TileImage.set_texture(_MountainAsset)
			tile.Resources = Enums.TileResources.Stone
		Enums.TileType.Farm:
			tile.name = "Farm"
			tile.TileImage.set_texture(_FarmAsset)
			tile.Resources = Enums.TileResources.Wheat
		Enums.TileType.GrassLand:
			tile.name = "GrassLand"
			tile.TileImage.set_texture(_GrasslandAsset)
			tile.Resources = Enums.TileResources.Sheep
		_:
			print("Hello Default")

func On_Edge_Clicked(tileX:int, tileY:int, Edgeindex:int):
	var tile = Tiles[tileX][tileY]
	var neighbourX = 0
	var neighbourY = 0
	match Edgeindex:
		1:
			neighbourY = tileY - 1
			if tileY%2 == 1 :
				neighbourX = tileX + 1
			else:
				neighbourX = tileX
		2:
			neighbourX = tileX + 1
			neighbourY = tileY
		3:
			neighbourY = tileY + 1
			if tileY%2 == 1 :
				neighbourX = tileX + 1
			else:
				neighbourX = tileX
		4:
			neighbourY = tileY + 1
			if tileY%2 == 1 :
				neighbourX = tileX
			else:
				neighbourX = tileX - 1
		5:
			neighbourX = tileX - 1
			neighbourY = tileY
		6:
			neighbourY = tileY - 1
			if tileY%2 == 1 :
				neighbourX = tileX
			else:
				neighbourX = tileX - 1
		_:
			print("Invalid EdgeIndex")
	var neighbourtile = Tiles[neighbourX][neighbourY]
	
	var Debugprint : String = ""
	Debugprint = str("Clicked on tile with ", tile.name, " property at ", 
		tileX,", ",tileY , " at edge ", Edgeindex)
		
	if neighbourtile:
		Debugprint+= str(" Found Neightbour with ", neighbourtile.name, " property at ", 
			neighbourX,", ",neighbourY , " at edge ", (Edgeindex + 3)%6)
	print(Debugprint)
	

func On_Vertex_Clicked(tileX:int, tileY:int, Vertexindex:int):
	var tile = Tiles[tileX][tileY]
	print("Clicked on tile with ", tile.name, " property at ", 
		tileX,", ",tileY , " at Vertex ", Vertexindex)
	
	var neighbourL:Vector2i = Vector2i(-1,-1)
	var neighbourR:Vector2i = Vector2i(-1,-1)
	
	match Vertexindex:
		1:
		2:
			neighbourL.x = tileX + 1
			neighbourL.y = tileY
			
			neighbourR.x = tileX + 1 if IsOdd(tileY) else tileX
		3:
		4:
		5:
		6:
		_:
			print("Invalid VertexIndex")

func IsOdd(val:int)-> bool:
	if val % 2 == 1:
		return true
	return false
