extends Node


func _ready() -> void:
	Global.obj.paradies = Classes_0.Paradies.new()
	Global.obj.hölle = Classes_1.Hölle.new()
	Global.obj.hölle.arr.küche.front().obj.koch.stir_dieners_into_kessels()
	#datas.sort_custom(func(a, b): return a.value < b.value) 012


func _input(event) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_SPACE:
				if event.is_pressed() && !event.is_echo():
					pass


func _process(delta_) -> void:
	$FPS.text = str(Engine.get_frames_per_second())
