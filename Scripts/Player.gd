extends KinematicBody

func _ready():
	pass

func _physics_process(delta):
	var x = 0
	var y = 0

	if Input.is_action_pressed("right"):
		x = 1
	elif Input.is_action_pressed("left"):
		x = -1
	if Input.is_action_pressed("backward"):
		y = 1
	elif Input.is_action_pressed("forward"):
		y = -1
	
	var velocity = (global_transform.basis.y * y + global_transform.basis.x * x).normalized()
	move_and_slide(velocity)
