extends Control

class_name Houses

var Neighbour1: Enums.TileResources
var Neighbour2: Enums.TileResources
var Neighbour3: Enums.TileResources

var Neighbour1DiceRoll: int
var Neighbour2DiceRoll: int
var Neighbour3DiceRoll: int

var IsCity: bool

func _SetupData(Nbour1RT:Enums.TileResources, 
	Nbour2RT:Enums.TileResources, Nbour3RT:Enums.TileResources,
	N1Dr, N2Dr, N3Dr):
	$Settlement.set_global_rotation(0)
	$City.set_global_rotation(0)
	Neighbour1 = Nbour1RT
	Neighbour2 = Nbour2RT
	Neighbour3 = Nbour3RT
	Neighbour1DiceRoll = N1Dr
	Neighbour2DiceRoll = N2Dr
	Neighbour3DiceRoll = N3Dr

func _on_button_pressed():
	IsCity = true
	$Settlement.visible = false
	$City.visible = true
