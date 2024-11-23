extends Node2D

class_name  CustTile

signal EdgeClicked
signal VertexClicked

@export var TileType:Enums.TileType = Enums.TileType.Desert

var Quantity: int = 0

@export var Resources:Enums.TileResources = Enums.TileResources.NIL

@onready var Edge1 = $Sprite2D/Edges/Pivot1/Edge1
@onready var Edge2 = $Sprite2D/Edges/Pivot2/Edge2
@onready var Edge3 = $Sprite2D/Edges/Pivot3/Edge3

@onready var Edge4 = $Sprite2D/Edges/Pivot1/Edge4
@onready var Edge5 = $Sprite2D/Edges/Pivot2/Edge5
@onready var Edge6 = $Sprite2D/Edges/Pivot3/Edge6

@onready var Vertex1 = $Sprite2D/Vertices/Pivot1/Vertex1
@onready var Vertex2 = $Sprite2D/Vertices/Pivot2/Vertex2
@onready var Vertex3 = $Sprite2D/Vertices/Pivot3/Vertex3

@onready var Vertex4 = $Sprite2D/Vertices/Pivot1/Vertex4
@onready var Vertex5 = $Sprite2D/Vertices/Pivot2/Vertex5
@onready var Vertex6 = $Sprite2D/Vertices/Pivot3/Vertex6


@onready var TileImage = $Sprite2D
@onready var LabelText = $Sprite2D/Label
@onready var DiceRollText = $Sprite2D/Label2

var tileX:int = -1
var tileY:int = -1
var DiceRollVal:int = -1

func _ready():
	Edge1.pressed.connect(_EdgePressed.bind(1))
	Edge2.pressed.connect(_EdgePressed.bind(2))
	Edge3.pressed.connect(_EdgePressed.bind(3))
	Edge4.pressed.connect(_EdgePressed.bind(4))
	Edge5.pressed.connect(_EdgePressed.bind(5))
	Edge6.pressed.connect(_EdgePressed.bind(6))
	
	Vertex1.pressed.connect(_VertexPressed.bind(1))
	Vertex2.pressed.connect(_VertexPressed.bind(2))
	Vertex3.pressed.connect(_VertexPressed.bind(3))
	Vertex4.pressed.connect(_VertexPressed.bind(4))
	Vertex5.pressed.connect(_VertexPressed.bind(5))
	Vertex6.pressed.connect(_VertexPressed.bind(6))

func _EdgePressed(Edgeindex:int):
	emit_signal("EdgeClicked", tileX, tileY, Edgeindex)
	
func _VertexPressed(Vertexindex:int):
	emit_signal("VertexClicked", tileX, tileY, Vertexindex)
	
func _GetVertex(VertexIndex:int) -> Button:
	match VertexIndex:
		1:
			return Vertex1
		2:
			return Vertex2
		3:
			return Vertex3
		4:
			return Vertex4
		5:
			return Vertex5
		6:
			return Vertex6
		_:
			return null
