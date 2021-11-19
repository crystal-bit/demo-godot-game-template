extends Node2D

onready var element_scene := load("res://objects/element/element.tscn")
var rows = 3
var cols = 3
var elements = []


func _ready():
	yield(get_tree(), "idle_frame")
	var s = 10 # spacing
	for i in range(rows):
		var row = []
		for j in range(cols):
			var element: Element = element_scene.instance()
			element.scale = Vector2(3, 3)
			var w = element.size().x
			var h = element.size().y
			element.position = Vector2(i * (w + s), j * (h + s))
			element.set_random_color()
			add_child(element)
			row.push_back(element)
		elements.push_back(row)
	call_deferred("layout")


func layout():
	var top_left = elements[0][0]
	var bottom_right = elements[2][2]
	var texture_size = top_left.size()
	var size = bottom_right.position - top_left.position + texture_size
	position = texture_size / 2 - size / 2 + Game.size / 2


func print_elements():
	for i in range(elements.size()):
		var s = ""
		for j in range(elements[i].size()):
			s += elements[i][j].name + ", "
		print(s)
