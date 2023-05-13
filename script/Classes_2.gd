extends Node


#Слуга diener
class Diener:
	var word = {}
	var num = {}
	var obj = {}
	var scene = {}


	func _init(input_) -> void:
		obj.wirt = input_.wirt
		init_schaufensterpuppe()
		init_koch()
		init_scene()
		set_specialty()


	func init_schaufensterpuppe() -> void:
		var input = {}
		input.diener = self
		obj.schaufensterpuppe = Classes_3.Schaufensterpuppe.new(input)


	func init_koch() -> void:
		var input = {}
		input.diener = self
		obj.koch = Classes_4.Koch.new(input)


	func init_scene() -> void:
		scene.myself = Global.scene.diener.instantiate()
		scene.myself.set_parent(self)


	func set_specialty() -> void:
		word.specialty = obj.wirt.word.archetype+" minion"


#Хозяин wirt
class Wirt:
	var word = {}
	var obj = {}
	var arr = {}
	var scene = {}


	func _init(input_) -> void:
		word.archetype = input_.archetype
		obj.gottheit = input_.gottheit
		obj.kessel = null
		init_dieners()
		distribute_ausstattungs()


	func init_dieners() -> void:
		arr.diener = []
		var dieners = 1
		
		match word.archetype:
			"Tyrant":
				dieners = 1
			"Leader":
				dieners = 4
			"Overlord":
				dieners = 9
		
		for _i in dieners:
			var input = {}
			input.wirt = self
			var diener = Classes_2.Diener.new(input)
			arr.diener.append(diener)


	func distribute_ausstattungs() -> void:
		var types = ["weapon", "apparel"]
		var rarity = 0
		
		for diener in arr.diener:
			for type in types:
				var input = {}
				input.type = type
				input.rarity = rarity
				
				match type:
					"weapon":
						input.slots = ["left hand"]
						
						if word.archetype == "Tyrant":
							input.slots.append("right hand")
					"apparel":
						input.slots = ["torso"]
				
				match word.archetype:
					"Tyrant":
						input.size = 3
					"Leader":
						input.size = 2
					"Overlord":
						input.size = 1
				
				var ausstattung = Classes_3.Ausstattung.new(input)
				diener.obj.schaufensterpuppe.equip_ausstattung(ausstattung)


	func get_side() -> String:
		var a = obj.kessel.obj.küche.dict.kessel
		return obj.kessel.obj.küche.dict.kessel[obj.gottheit].front().word.side
