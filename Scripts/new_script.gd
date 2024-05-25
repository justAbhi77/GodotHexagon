extends Resource

class_name testdataClass

@export var vartestdata: int = 5

@export var testsmth: Vector2 = Vector2( - 79, 82)

func _to_string() -> String:
    return "{0}, {1}".format([vartestdata, testsmth])

func change_value(change_val: int, vector2: Vector2):
    vartestdata = change_val
    testsmth = vector2

func copy_from_obj(otherobj: testdataClass):
    if otherobj is testdataClass:
        change_value(otherobj.vartestdata, otherobj.testsmth)