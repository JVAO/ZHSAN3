extends Node
class_name Skill

var id: int setget forbidden
var scenario

var gname: String setget forbidden

var operation: String setget forbidden
var value: float setget forbidden

func forbidden(x):
	assert(false)

func load_data(json: Dictionary):
	id = json["_Id"]
	gname = json["Name"]
	operation = json["Operation"]
	value = json["Value"]
	
func save_data() -> Dictionary:
	return {
		"_Id": id,
		"Name": gname,
		"Operation": operation,
		"Value": value
	}

func get_name() -> String:
	return gname
