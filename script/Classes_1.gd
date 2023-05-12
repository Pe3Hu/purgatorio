extends Node


#Котел
class Kessel:
	var word = {}
	var obj = {}
	var scene = {}


	func _init(input_) -> void:
		word.side = input_.side
		obj.küche = input_.küche
		obj.wirt = input_.wirt
		obj.wirt.obj.kessel = self
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.kessel.instantiate()
		scene.myself.set_parent(self)
		obj.küche.scene.myself.add_kessel(self)


#Повар
class Koch:
	var obj = {}


	func _init(input_) -> void:
		obj.küche = input_.küche


	func get_kessel_for(wirt_) -> void:
		var input = {}
		input.küche = obj.küche
		input.wirt = wirt_
		input.side = obj.küche.dict.side[wirt_.obj.gottheit]
		var kessel = Classes_1.Kessel.new(input)
		obj.küche.dict.kessel[wirt_.obj.gottheit].append(kessel)


	func stir_dieners_into_kessels() -> void:
		for gottheit in obj.küche.dict.kessel.keys():
			for kessel in obj.küche.dict.kessel[gottheit]:
				kessel.scene.myself.stir()


#Кухня küche
class Küche:
	var arr = {}
	var obj = {}
	var dict = {}
	var scene = {}


	func _init(input_) -> void:
		obj.hölle = input_.hölle
		dict.side = {}
		dict.kessel = {}
		init_koch()
		init_scene()


	func init_koch() -> void:
		var input = {}
		input.küche = self
		obj.koch = Classes_1.Koch.new(input)


	func init_scene() -> void:
		scene.myself = Global.scene.küche.instantiate()
		scene.myself.set_parent(self)
		obj.hölle.scene.myself.add_child(scene.myself)


	func add_gottheit(gottheit_) -> void:
		if dict.side.keys().size() < Global.arr.side.size():
			var side = null
		
			if dict.side.keys().size() == 0:
				side = Global.arr.side.front()
			else:
				side = Global.arr.side.back()
			
			dict.side[gottheit_] = side
			dict.kessel[gottheit_] = []
			
			for wirt in gottheit_.arr.wirt:
				obj.koch.get_kessel_for(wirt)
		else:
			print("error add_gottheit: gottheits size > 2")


#Ад
class Hölle:
	var arr = {}
	var scene = {}


	func _init() -> void:
		init_scene()
		init_küches()
		
		for gottheit in Global.obj.paradies.arr.gottheit:
			arr.küche.front().add_gottheit(gottheit)
		
		scene.myself.update_columns()


	func init_scene() -> void:
		scene.myself = Global.scene.hölle.instantiate()
		scene.myself.set_parent(self)
		Global.node.game.get_node("Layer1").add_child(scene.myself)


	func init_küches() -> void:
		arr.küche = []
		var n = 1
		
		for _i in n:
			var input = {}
			input.hölle = self
			var küche = Classes_1.Küche.new(input)
			arr.küche.append(küche)
