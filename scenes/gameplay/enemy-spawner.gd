extends Node

signal enemy_killed

onready var enemy_scene = preload("res://objects/enemy/enemy.tscn")
onready var timer := $Timer

var spawned_enemies = 0

func _ready():
	timer.start()


func spawn():
	var enemy: Enemy = enemy_scene.instance()
	enemy.translation.y = 20
	enemy.connect("killed", self, "on_enemy_killed")
	add_child(enemy)


func on_enemy_killed(enemy):
	emit_signal("enemy_killed")


func _on_Timer_timeout():
	spawn()
	spawned_enemies += 1
	if spawned_enemies % 5 == 0:
		timer.wait_time *= 0.5
		timer.wait_time = max(0.15, timer.wait_time)
