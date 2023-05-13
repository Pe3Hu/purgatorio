extends Node


#Жетон wertmarke
class Wertmarke:
	var num = {}
	var word = {}
	var obj = {}
	var scene = {}


	func _init(input_) -> void:
		num.value = input_.value
		word.source = input_.source
		obj.stapel = null
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.wertmarke.instantiate()
		scene.myself.set_parent(self)


#стек жетонов stapel
class Stapel:
	var arr = {}
	var obj = {}
	var scene = {}


	func _init(input_) -> void:
		arr.parent = input_.parents
		obj.wertmarke = input_.wertmarke
		obj.absicht = input_.absicht
		obj.target = null
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.stapel.instantiate()
		scene.myself.set_parent(self)


#Намерение absicht
class Absicht:
	var dict = {}
	var arr = {}
	var scene = {}


	func _init(input_) -> void:
		dict.condition = input_.condition
		arr.bedrohung = input_.bedrohungs
		arr.stapel = []
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.absicht.instantiate()
		scene.myself.set_parent(self)


#Угроза bedrohung
class Bedrohung:
	var num = {}
	var word = {}
	var obj = {}
	var scene = {}


	func _init(input_) -> void:
		obj.parent = input_.diener
		num.value = input_.value
		word.source = input_.source
		word.side = input_.side
		word.target = input_.target
		word.scope = input_.scope


#Повар koch 
class Koch:
	var word = {}
	var obj = {}
	var scene = {}


	func _init(input_) -> void:
		obj.diener = input_.diener


	func roll_attack() -> void:
		var damage = obj.diener.obj.schaufensterpuppe.num.indicator.damage
		Global.rng.randomize()
		damage.current = round(Global.rng.randi_range(damage.min,damage.max))
		create_wertmarkes_based_on_damage()


	func create_wertmarkes_based_on_damage() -> void:
		var input = {}
		input.diener = obj.diener
		input.side = obj.diener.obj.wirt.get_side()
		input.target = "min hp"
		input.scope = "diener"
		var damage = obj.diener.obj.schaufensterpuppe.num.indicator.damage.current
		var sources = ["physical","fire"]
		sources.shuffle()
		input.source = sources.front()#"physical"
		var values = Global.dict.wertmarke[input.source]
		var kits = Global.backpacking_options(values, damage)
		
		if kits.size() > 0:
			input.values = kits.front()
			
			for value in input.values:
				input.value = value
				var bedrohung = Classes_4.Bedrohung.new(input)
				obj.diener.obj.wirt.obj.kessel.obj.küche.obj.kellner.arr.bedrohung.append(bedrohung)
				
		#print(damage,obj.diener.obj.schaufensterpuppe.num.indicator.damage)
