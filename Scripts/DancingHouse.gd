extends Spatial

var dir = true
var timer = 0.25

func _process(delta):
	if timer <= 0:
		dir = !dir
		timer = 0.5
	rotate_z(0.6 * delta * (1 if dir else -1))
	timer -= delta
