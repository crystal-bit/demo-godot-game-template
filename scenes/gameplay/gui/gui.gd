extends Control

onready var score_value = $Control/HBoxContainer/Value


func set_score(val):
	score_value.text = str(val)


func _on_Enemies_enemy_killed():
	set_score(int(score_value.text) + 1)
