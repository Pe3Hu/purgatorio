extends Node


#Владение
class Besitz:
	var obj = {}


	func _init(input_) -> void:
		obj.küche = input_.küche


#Повар kellner 
class Kellner:
	var word = {}
	var obj = {}
	var scene = {}


	func _init(input_) -> void:
		obj.gottheit = input_.gottheit


#Божество
class Gottheit:
	var arr = {}
	var obj = {}


	func _init(input_) -> void:
		obj.paradies = input_.paradies
		obj.küche = null
		init_kellner()
		init_wirts()


	func init_kellner() -> void:
		var input = {}
		input.gottheit = self
		obj.kellner = Classes_0.Kellner.new(input)


	func init_wirts() -> void:
		arr.wirt = []
		var archetypes = ["Tyrant","Leader","Overlord"]
		
		for archetype in archetypes:
			var input = {}
			input.archetype = archetype
			input.gottheit = self
			var wirt = Classes_2.Wirt.new(input)
			arr.wirt.append(wirt)


#Рай
class Paradies:
	var arr = {}


	func _init() -> void:
		init_gottheits()


	func init_gottheits() -> void:
		arr.gottheit = []
		var n = 2
		
		for _i in n:
			var input = {}
			input.paradies = self
			var gottheit = Classes_0.Gottheit.new(input)
			arr.gottheit.append(gottheit)
