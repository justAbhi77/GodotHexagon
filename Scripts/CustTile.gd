extends Node2D

class_name  CustTile

signal TileClicked

@export var TileType:Enums.TileType = Enums.TileType.Desert

var Quantity: int = 0

@export var Resources:Enums.TileResources = Enums.TileResources.NIL

@onready var Edge1 = $Sprite2D/Edge1
@onready var Edge3 = $Sprite2D/Edge3
@onready var Edge5 = $Sprite2D/Edge5
@onready var TileImage = $Sprite2D

var tileX:int = -1
var tileY:int = -1

func _ready():
	Edge1.pressed.connect(_ButtonPressed.bind(1))
	Edge3.pressed.connect(_ButtonPressed.bind(3))
	Edge5.pressed.connect(_ButtonPressed.bind(5))

func _ButtonPressed(Edgeindex:int):
	emit_signal("TileClicked", tileX, tileY, Edgeindex)
