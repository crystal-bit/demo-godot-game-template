extends Node


export(PackedScene) var star

func _ready(count = 500):
	for i in range(count):
		var s = star.instance()
		add_child(s)
		s.randomize_position()
