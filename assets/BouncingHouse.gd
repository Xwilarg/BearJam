extends Spatial

export var dir = true
var timer = 0.25

func _process(delta):
	if timer <= 0:
		dir = !dir
		timer = 0.5
	var mov = 0.6 * delta * (1 if dir else -1)
	scale = Vector3(scale.x + mov, scale.y - mov, scale.z)
	timer -= delta
