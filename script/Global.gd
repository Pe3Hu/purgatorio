extends Node


var rng = RandomNumberGenerator.new()
var num = {}
var dict = {}
var arr = {}
var obj = {}
var node = {}
var flag = {}
var vec = {}
var scene = {}
var theme = {}
var stats = {}


func init_num() -> void:
	num.index = {}
	
	num.wertmarke = {}
	num.wertmarke.size = {}
	num.wertmarke.size.x = 24
	num.wertmarke.size.y = 24
	num.wertmarke.size.r = {}
	num.wertmarke.size.R = {}
	#num.wertmarke.size.a = num.wertmarke.size.r*6/sqrt(3)
	
	var corners = [3,4]
	
	for corner in corners:
		match corner:
			3:
				num.wertmarke.size.r[corner] = num.wertmarke.size.x/2
				num.wertmarke.size.R[corner] = num.wertmarke.size.x
				#better vision
				num.wertmarke.size.r[corner] *= 2
				num.wertmarke.size.R[corner] *= 1
			4:
				num.wertmarke.size.r[corner] = num.wertmarke.size.x/2
				num.wertmarke.size.R[corner] = num.wertmarke.size.x/2*sqrt(2)
				#better vision
				num.wertmarke.size.r[corner] *= 1.5
				num.wertmarke.size.R[corner] *= 1.5


func init_dict() -> void:
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
	
	init_wertmarkes()
	init_bedrohung_corners()


func init_wertmarkes() -> void:
	dict.wertmarke = {}
	arr.source = ["physical","fire"]
	var max_pow = 6
	
	for source in arr.source:
		dict.wertmarke[source] = []
		
		for _i in range(2,max_pow,1):
			var value = pow(_i,2)-1
			dict.wertmarke[source].append(value)
		
	#var arr_ = [3,7,15]
	#arr_.append({"weight": 3, "value": 3})
	#arr_.append({"weight": 7, "value": 7})
	#arr_.append({"weight": 15, "value": 15})
	#arr_.append({"weight": 4, "value": 4000})
	#arr_.append({"weight": 3, "value": 2500})
	#arr_.append({"weight": 3, "value": 2000})
	#var r = backpacking_options(arr_, 22)
	#print(r)


func init_bedrohung_corners() -> void:
	dict.order = {}
	dict.order.pair = {}
	dict.order.pair["even"] = "odd"
	dict.order.pair["odd"] = "even"
	var corners = [3,4,6]
	dict.bedrohung = {}
	dict.bedrohung.corner = {}
	dict.bedrohung.corner.vector = {}
	
	for corners_ in corners:
		dict.bedrohung.corner.vector[corners_] = {}
		dict.bedrohung.corner.vector[corners_].even = {}
		
		for order_ in dict.order.pair.keys():
			dict.bedrohung.corner.vector[corners_][order_] = {}
		
			for _i in corners_:
				var angle = 2*PI*_i/corners_-PI/2
				
				if order_ == "odd":
					angle += PI/corners_
				
				var vertex = Vector2(1,0).rotated(angle)
				dict.bedrohung.corner.vector[corners_][order_][_i] = vertex
	
	init_bedrohung_corner_description()
	


func init_bedrohung_corner_description() -> void:
	dict.bedrohung.corner.description = {}
	var path = "res://asset/json/bedrohung_corner_data.json"
	var array = load_data(path)
	
	for dict_ in array:
		var indexs = []
		
		for key in dict_.keys():
			if "corner" in key and dict_[key] == 1:
				var index = int(key.right(1))
				indexs.append(index)
		
		if !dict.bedrohung.corner.description.keys().has(dict_["scope"]):
			dict.bedrohung.corner.description[dict_["scope"]] = {}
			
		if !dict.bedrohung.corner.description[dict_["scope"]].keys().has(dict_["criterion"]):
			dict.bedrohung.corner.description[dict_["scope"]][dict_["criterion"]] = {}
		
		dict.bedrohung.corner.description[dict_["scope"]][dict_["criterion"]][dict_["extreme"]] = indexs


func init_title() -> void:
	dict.title = {}
	var path = "res://asset/json/wohnwagen_title_data.json"
	var array = load_data(path)
	
	for key in array.front().keys():
		dict.title[key] = []
	
	for dict_ in array:
		for key in dict_.keys():
			dict.title[key].append(dict_[key])


func init_arr() -> void:
	arr.neighbor = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 1, 1), 
			Vector2( 0, 1), 
			Vector2(-1, 0),
			Vector2( 0,-1)
		],
		[
			Vector2( 0,-1),
			Vector2( 1, 0),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2(-1,-1)
		]
	]
	arr.spin = [
		[
			Vector2( 1,-1), 
			Vector2( 0, 1), 
			Vector2( 0, 1), 
			Vector2( 0, 1), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2( 0,-1),
			Vector2( 0,-1),
			Vector2( 0,-1)
		]
	]
	arr.side = ["left","right"]
	arr.slot = ["left hand","right hand", "torso"]
	arr.indicator = ["health","damage"]
	arr.border = ["min","current","max"]


func init_node() -> void:
	node.game = get_node("/root/Game")


func init_scene() -> void:
	scene.hölle = load("res://scene/1/hölle.tscn")
	scene.küche = load("res://scene/1/küche.tscn")
	scene.kessel = load("res://scene/1/kessel.tscn")
	scene.diener = load("res://scene/2/diener.tscn")
	scene.absicht = load("res://scene/4/absicht.tscn")
	scene.bedrohungs = load("res://scene/4/bedrohungs.tscn")
	scene.stapel = load("res://scene/4/stapel.tscn")
	scene.wertmarke = load("res://scene/4/wertmarke.tscn")


func init_vec():
	vec.size = {}
	vec.size.kessel = Vector2(72, 72)
	
	init_window_size()


func init_theme():
	for source in arr.source:
		var n = 24
		var style_box = StyleBoxFlat.new()
		style_box.corner_radius_top_left = n
		style_box.corner_radius_top_right = n
		style_box.corner_radius_bottom_left = n
		style_box.corner_radius_bottom_right = n
		var color = Color() 
		
		match source:
			"physical":
				color = Color("white")
			"fire":
				color = Color("red")
		
		style_box.resource_local_to_scene = true
		style_box.bg_color = color
		theme[source] = style_box
	
	return


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func _ready() -> void:
	init_num()
	init_dict()
	init_arr()
	init_node()
	init_scene()
	init_vec()
	init_theme()


func get_random_element(array_: Array):
	if array_.size() == 0:
		print("!bug! empty array in get_random_element func")
		return null
	
	rng.randomize()
	var index_r = rng.randi_range(0, array_.size()-1)
	return array_[index_r]


func split_two_point(points_: Array, delta_: float):
	var a = points_.front()
	var b = points_.back()
	var x = (a.x+b.x*delta_)/(1+delta_)
	var y = (a.y+b.y*delta_)/(1+delta_)
	var point = Vector2(x, y)
	return point


func save(path_: String, data_: String):
	var path = path_+".json"
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.save(data_)
	file.close()


func load_data(path_: String):
	var file = FileAccess.open(path_,FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var parse_err = json_object.parse(text)
	return json_object.get_data()


func get_manhattan_distance(a_: Vector3, b_: Vector3) -> int:
	var d = 0
	d += abs(a_.x-b_.x)
	d += abs(a_.y-b_.y)
	d += abs(a_.z-b_.z)
	return d


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


func reverse_weights(dict_: Dictionary) -> Dictionary:
	var result = {}
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	for key in dict_.keys():
		result[key] = total-dict_[key]
	
	total = 0
	
	for key in result.keys():
		total += result[key]
	
	for key in result.keys():
		result[key] = round(float(result[key])/total*100)
	
	return result


func from_weight_to_percentage(dict_: Dictionary) -> Dictionary:
	var result = {}
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	for key in dict_.keys():
		result[key] = round(float(dict_[key])/total*100)
	
	return result


func get_all_substitution(array_: Array):
	var result = [[]]
	
	for _i in array_.size():
		var slot_options = array_[_i]
		var next = []
		
		for arr_ in result:
			for option in slot_options:
				var pair = []
				pair.append_array(arr_)
				pair.append(option)
				next.append(pair)
		
		result = next
		for _j in range(result.size()-1,-1,-1):
			if result[_j].size() < _i+1:
				result.erase(result[_j])
	
	return result


func get_all_subparts(array_: Array, subpart_sizes_: Array, parametr_: String):
	var result = {}
	var perms = get_all_perms(array_)
	
	for subpart_size in subpart_sizes_:
		result[subpart_size] = []
	
	for perm in perms:
		for subpart_size in subpart_sizes_:
			var subpart = []
			
			for _i in subpart_size:
				subpart.append(perm[_i])
			
			match parametr_:
				"servants":
					subpart.sort_custom(func(a, b): return a.num.index > b.num.index)
				"pureblood":
					subpart.sort_custom(func(a, b): return a.num.index > b.num.index)
				"hierarchy":
					subpart.sort()
			
			if !result[subpart_size].has(subpart):
				result[subpart_size].append(subpart)
	
	return result


func get_all_perms(array_: Array):
	var result = []
	perm(result, array_, 0)
	return result


func perm(result_: Array, array_: Array, l_: int):
	if l_ >= array_.size():
		var array = []
		array.append_array(array_)
		result_.append(array)
		return
	
	perm(result_, array_, l_+1)
	
	for _i in range(l_+1,array_.size(),1):
		swap(array_, l_, _i)
		perm(result_, array_, l_+1)
		swap(array_, l_, _i)


func swap(array_: Array, i_: int, j_: int):
	var temp = array_[i_]
	array_[i_] = array_[j_]
	array_[j_] = temp


func conjunction(n_: int, m_: int) -> int:
	var result = factorial(n_)
	result /= factorial(n_ - m_)
	result /= factorial(m_)
	return result


func factorial(n_: int) -> int:
	var result = 1
	
	for _i in range(2,n_+1,1):
		result *= _i
	
	return result


func get_gaussian_distribution(scale_: int):
	rng.randomize()
	#var distribution = (rng.randfn(0,5.0)/5+1)*0.5
	var deviation = pow(5.0,float(1.0/2.0))
	var distribution = rng.randfn(0.5,0.2)
	
	while distribution > 1:
		distribution = rng.randfn(0.5,0.2)
	
	return abs(round(distribution*scale_))


func backpacking_options_advanced(arr_: Array, max_capacity: int):
	var indexs = []
	var tree = [[]]
	
	for _i in arr_.size():
		var leaf = arr_[_i]
		var branch_ = {}
		branch_.indexs = [_i]
		branch_.weight = leaf.weight
		tree[0].append(branch_)
	
	var flag = true
	
	while flag:
		flag = false
		var branchs = tree.back()
		var buds = []
		
		for branch in branchs:
			var end_branch = true
			
			for _i in arr_.size():
				if _i >= branch.indexs.back():
					var leaf = arr_[_i]
					var branch_ = {}
					branch_.indexs = []
					branch_.indexs.append_array(branch.indexs)
					branch_.indexs.append(_i)
					branch_.weight = leaf.weight+branch.weight
					
					if max_capacity >= branch_.weight:
						buds.append(branch_) 
						flag = true
						end_branch = false
			
			if end_branch:
				indexs.append((branch.indexs))
		
		if buds.size() > 0:
			tree.append(buds)
		else:
			flag = false
	
	var datas = []
	
	for indexs_ in indexs:
		var data = {}
		data.indexs = indexs_
		data.value = 0
		
		for index in indexs_:
			data.value += arr_[index].value
		
		datas.append(data)
	
	datas.sort_custom(func(a, b): return a.value > b.value)
	var bests = []
	
	for data in datas:
		if data.value == datas.front().value:
			bests.append(data.indexs)
	
	return bests


func backpacking_options(weights_: Array, max_capacity: int):
	var indexs = []
	var tree = [[]]
	
	for _i in weights_.size():
		if max_capacity >= weights_[_i]:
			var branch_ = {}
			branch_.indexs = [_i]
			branch_.weight = weights_[_i]
			tree[0].append(branch_)
	
	var flag = true
	
	while flag:
		flag = false
		var branchs = tree.back()
		var buds = []
		
		for branch in branchs:
			var end_branch = true
			
			for _i in weights_.size():
				if _i >= branch.indexs.back() and max_capacity >= weights_[_i]:
					var branch_ = {}
					branch_.indexs = []
					branch_.indexs.append_array(branch.indexs)
					branch_.indexs.append(_i)
					branch_.weight = weights_[_i]+branch.weight
					
					if max_capacity >= branch_.weight:
						buds.append(branch_) 
						flag = true
						end_branch = false
			
			if end_branch:
				indexs.append((branch.indexs))
		
		if buds.size() > 0:
			tree.append(buds)
		else:
			flag = false
	
	var datas = []
	
	for indexs_ in indexs:
		var data = {}
		data.indexs = indexs_
		data.weight = 0
		
		for index in indexs_:
			data.weight += weights_[index]
		
		datas.append(data)
	
	datas.sort_custom(func(a, b): return a.weight > b.weight)
	var best_results = []
	
	for data in datas:
		if data.weight == datas.front().weight:
			var weights = []
			
			for _i in data.indexs:
				weights.append(weights_[_i])
			
			best_results.append(weights)
	
	return best_results
