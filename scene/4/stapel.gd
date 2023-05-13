extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	set_wertmarke()
	update_stack()


func set_wertmarke() -> void:
	$HBoxContainer/WertmarkeContainer.add_child(parent.obj.wertmarke.scene.myself)


func update_stack() -> void:
	$HBoxContainer/LabelContainer/Stack .text = "x"+str(1)
