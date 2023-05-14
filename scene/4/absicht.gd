extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	init_bedrohungs()


func init_bedrohungs() -> void:
	var wertmarke_inputs = []
	
	for bedrohung in parent.arr.bedrohung:
		var wertmarke_input = {}
		wertmarke_input.value = bedrohung.num.value
		wertmarke_input.source = bedrohung.word.source
		
		if !wertmarke_inputs.has(wertmarke_input):
			wertmarke_inputs.append(wertmarke_input)
	
	for wertmarke_input in wertmarke_inputs:
		var input = {}
		input.parents = []
		input.absicht = parent
		input.wertmarke = Classes_4.Wertmarke.new(wertmarke_input)
		
		for bedrohung in parent.arr.bedrohung:
			if bedrohung.num.value == wertmarke_input.value and bedrohung.word.source == wertmarke_input.source:
				input.parents.append(bedrohung.obj.parent)
		
		input.stack = input.parents.size()
		var stapel = Classes_4.Stapel.new(input)
		input.wertmarke.obj.stapel = stapel
		parent.arr.stapel.append(stapel)
		
	for stapel in parent.arr.stapel:
		var bedrohungs = Global.scene.bedrohungs.instantiate()
		bedrohungs.set_vars( parent.dict.condition, stapel)
		$bedrohungs.add_child(bedrohungs)
