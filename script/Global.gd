extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	init_node()
	init_scene()


func init_arr() -> void:
	arr.edge = [1, 2, 3, 4, 5, 6]
	arr.side = ["left", "right"]
	arr.quartet = ["verse", "interlude", "apotheosis", "mana"]


func init_num() -> void:
	num.index = {}
	
	num.area = {}
	num.area.col = 5
	num.area.row = num.area.col


func init_dict() -> void:
	init_neighbor()


func init_neighbor() -> void:
	dict.neighbor = {}
	dict.neighbor.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.neighbor.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.neighbor.hex = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]


func init_blank() -> void:
	dict.blank = {}
	dict.blank.title = {}
	
	var path = "res://asset/json/poupou_blank.json"
	var array = load_data(path)
	
	for blank in array:
		var data = {}
		
		for key in blank:
			if key != "title":
				data[key] = blank[key]
		
		dict.blank.title[blank.title] = data


func init_node() -> void:
	node.game = get_node("/root/Game")


func init_scene() -> void:
	scene.chef = load("res://scene/1/chef.tscn")
	scene.assistant = load("res://scene/1/assistant.tscn")
	scene.waiter = load("res://scene/1/waiter.tscn")
	
	scene.kitchen = load("res://scene/2/kitchen.tscn")
	scene.cauldron = load("res://scene/2/cauldron.tscn")
	scene.section = load("res://scene/2/section.tscn")
	
	scene.spell = load("res://scene/3/spell.tscn")
	
	scene.health = load("res://scene/4/health.tscn")
	scene.indicator = load("res://scene/4/indicator.tscn")


func init_vec():
	vec.size = {}
	vec.size.letter = Vector2(20, 20)
	vec.size.icon = Vector2(48, 48)
	vec.size.sixteen = Vector2(16, 16)
	vec.size.number = vec.size.sixteen#Vector2(5, 32)
	
	vec.size.aspect = Vector2(32, 32)
	vec.size.box = Vector2(100, 100)
	
	vec.size.section = Vector2(24, 24)
	vec.size.quartet = Vector2(72, 72)
	vec.size.bar = Vector2(vec.size.section)
	vec.size.marker = Vector2(vec.size.section)
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	
	color.defender = {}
	color.defender.active = Color.from_hsv(120 / h, 0.6, 0.7)


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null
