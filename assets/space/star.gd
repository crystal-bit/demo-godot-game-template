extends Sprite3D
class_name Star

func _ready():
	var textures = [
		preload("res://assets/puzzle/particleSmallStar.png"),
		preload("res://assets/puzzle/particleCartoonStar.png"),
		preload("res://assets/puzzle/particleStar.png")
	]
	texture = textures[randi() % 3]


func randomize_position():
	translation.x = rand_range(-20, 20)
	translation.y = rand_range(-20, 20)
	translation.z = rand_range(-12, 40)
	modulate.r = rand_range(.9, 1)
	modulate.g = rand_range(.9, 1)
	modulate.b = rand_range(.9, 1)
	if translation.z > 5:
		modulate.a = 0.3
