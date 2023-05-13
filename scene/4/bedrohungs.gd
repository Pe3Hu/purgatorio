extends MarginContainer


var condition = null
var stapel = null


func set_vars(condition_, stapel_) -> void:
	condition = condition_
	stapel = stapel_
	set_corners()


func set_corners() -> void:
	pass
