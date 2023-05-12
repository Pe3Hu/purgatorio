extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_


func update_health() -> void:
	$Value.text = str(parent.word.value)
	#update_color()
