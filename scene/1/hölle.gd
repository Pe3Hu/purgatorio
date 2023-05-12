extends GridContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_


func update_columns() -> void:
	columns = ceil(pow(parent.arr.küche.size(),float(1.0/2.0)))
