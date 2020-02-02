extends Node
class_name Scenario

var tile_size: int
var map_size: Vector2

var factions = Dictionary()
var architectures = Dictionary()
var persons = Dictionary()

signal scenario_loaded

# Called when the node enters the scene tree for the first time.
func _ready():
	_setup()
	
	_load_data("user://Scenarios/000Test.json")
	emit_signal("scenario_loaded")
	
func _setup():
	tile_size = ($Map as TileMap).cell_size[0]
	map_size = ($Map as TileMap).get_used_rect().size
	($MainCamera as MainCamera).scenario = self

func _load_data(path):
	var file = File.new()
	file.open(path, File.READ)
	
	var json = file.get_as_text()
	var obj = parse_json(json)
	
	var person_script = load("res://ScenarioScene/Person/Person.gd")
	for item in obj["Persons"]:
		var instance = person_script.new()
		instance.scenario = self
		instance.load_data(item)
		
		persons[instance.get_id()] = instance
		add_child(instance)
	
	var architecture_scene = load("res://ScenarioScene/Architecture/Architecture.tscn")
	for item in obj["Architectures"]:
		var instance = architecture_scene.instance()
		instance.scenario = self
		instance.load_data(item)
		
		for id in item["PersonList"]:
			instance.add_person(persons[int(id)])
		
		architectures[instance.get_id()] = instance
		add_child(instance)
		
	var faction_script = load("res://ScenarioScene/Faction/Faction.gd")
	for item in obj["Factions"]:
		var instance = faction_script.new()
		instance.scenario = self
		instance.load_data(item)
		
		for id in item["ArchitectureList"]:
			instance.add_architecture(architectures[int(id)])
		
		factions[instance.get_id()] = instance
		add_child(instance)
	
	
	
