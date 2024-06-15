extends Node2D

class_name  CustTile

@export var type:Enums.TileType = Enums.TileType.MaxDefault

var Quantity: int = 0

@export var Resources:Enums.TileResources = Enums.TileResources.NIL

@onready var Edge1 = $Sprite2D/Edge1
@onready var Edge3 = $Sprite2D/Edge3
@onready var Edge5 = $Sprite2D/Edge5

func _ready():
	Edge1.pressed.connect(_ButtonPressed.bind(1))
	Edge3.pressed.connect(_ButtonPressed.bind(3))
	Edge5.pressed.connect(_ButtonPressed.bind(5))

func _ButtonPressed(index:int):
	print(index)
