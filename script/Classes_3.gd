extends Node


#Оснащение ausstattung
class Ausstattung:
	var num = {}
	var word = {}
	var arr = {}
	var obj = {}


	func _init(input_) -> void:
		word.type = input_.type
		num.rarity = input_.rarity
		num.size = input_.size
		arr.slot = input_.slots
		obj.schaufensterpuppe = null
		set_bonus()


	func set_bonus():
		num.bonus = {}
		
		match word.type:
			"apparel":
				match num.size:
					3:
						num.bonus["health max"] = 70
					2:
						num.bonus["health max"] = 20
					1:
						num.bonus["health max"] = 10
			"weapon":
				match num.size:
					3:
						num.bonus["damage min"] = 3
						num.bonus["damage max"] = 15
					2:
						num.bonus["damage min"] = 1
						num.bonus["damage max"] = 11#7
					1:
						num.bonus["damage min"] = 0
						num.bonus["damage max"] = 4


	func apply_bonus() -> void:
		for key in num.bonus.keys():
			var keys = key.rsplit(" ", true)
			var indicator = keys[0]
			var border = keys[1]
			obj.schaufensterpuppe.num.indicator[indicator][border] += num.bonus[key]
			
			if indicator == "health":
				obj.schaufensterpuppe.num.indicator[indicator].current += num.bonus[key]


#Манекен schaufensterpuppe
class Schaufensterpuppe:
	var word = {}
	var num = {}
	var obj = {}
	var dict = {}


	func _init(input_) -> void:
		obj.diener = input_.diener
		init_indicators()
		init_slots()


	func init_indicators() -> void:
		num.indicator = {}
		
		for indicator in Global.arr.indicator:
			num.indicator[indicator] = {}
			
			for border in Global.arr.border:
				num.indicator[indicator][border] = 0


	func init_slots() -> void:
		dict.ausstattung = {}
		
		for slot in Global.arr.slot:
			dict.ausstattung[slot] = null


	func equip_ausstattung(ausstattung_) -> void:
		var empty = check_slots(ausstattung_.arr.slot)
		
		if empty:
			for slot in ausstattung_.arr.slot:
				dict.ausstattung[slot] = ausstattung_
			
			ausstattung_.obj.schaufensterpuppe = self
			ausstattung_.apply_bonus()
			
			if ausstattung_.word.type == "apparel":
				obj.diener.scene.myself.update_health()


	func check_slots(slots_) -> bool:
		for slot in slots_:
			if dict.ausstattung[slot] != null:
				print("error check_slots")
				return false
		
		return true

