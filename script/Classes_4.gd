extends Node


#Угроза bedrohung
class Bedrohung:
	var obj = {}
	var arr = {}
	var scene = {}


	func _init(input_) -> void:
		obj.diener = input_.diener
		arr.wertmarke = input_.wertmarkes
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.wertmarke.instantiate()
		scene.myself.set_parent(self)


#Жетон wertmarke
class Wertmarke:
	var word = {}
	var obj = {}
	var scene = {}


	func _init(input_) -> void:
		word.value = input_.value
		word.target = input_.target
		obj.bedrohung = null
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.wertmarke.instantiate()
		scene.myself.set_parent(self)


#Боец kämpfer
class Kämpfer:
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
		var damage = 15#obj.diener.obj.schaufensterpuppe.num.indicator.damage.current
		var source = "physical"
		var values = Global.dict.wertmarke[source]
		var options = []
		
		
		#print(damage,obj.diener.obj.schaufensterpuppe.num.indicator.damage)
