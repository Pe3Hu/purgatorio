extends HBoxContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_


func add_kessel(kessel_) -> void:
	var side = get_node(kessel_.word.side).get_node("kessels")
	side.add_child(kessel_.scene.myself)


func add_absicht(absicht_) -> void:
	var side = get_node(absicht_.dict.condition.side).get_node("absichts")
	side.add_child(absicht_.scene.myself)
