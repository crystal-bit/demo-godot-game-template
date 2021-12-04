extends Node


# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	print("\ngameplay.gd:pre_start() called with params = ")
	for key in params:
		var val = params[key]
		printt("", key, val)
	set_process(false)
	var spaceship = $Spatial/Spaceship
	var camera = $Spatial/Camera
	var d = camera.translation.distance_to(spaceship.translation)
	top_left = camera.project_position(Vector2(0, 0), d)
	bot_right = camera.project_position(Vector2(Game.size.x, Game.size.y), d)
	center = camera.project_position(Vector2(Game.size.x / 2, Game.size.y / 2), d)
	spaceship.translation = center


var top_left: Vector3
var bot_right: Vector3
var center: Vector3

# `start()` is called when the graphic transition ends.
func start():
	var active_scene: Node = Game.get_active_scene()
	set_process(true)


func _on_Spaceship_destroyed():
	var gameover = load("res://scenes/gameplay/game-over/game-over.tscn").instance()
	add_child(gameover)
	gameover.set_score($GUI.score_value.text)
