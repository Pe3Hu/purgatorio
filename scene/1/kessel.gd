extends GridContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	add_dieners()


func add_dieners() -> void:
	update_columns()
	
	for diener in parent.obj.wirt.arr.diener:
		diener.scene.myself.resize_by_wirt_archetype()
		diener.scene.myself.update_color()
		add_child(diener.scene.myself)


func update_columns() -> void:
	columns = ceil(pow(parent.obj.wirt.arr.diener.size(),float(1.0/2.0)))


func stir() -> void:
	for diener in get_children():
		diener.parent.obj.kellner.roll_attack()
