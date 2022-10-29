extends KinematicBody

var verRot: float
var speed = 12
var xSens = -1.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
	
	var velocity = (global_transform.basis.z * y + global_transform.basis.x * x).normalized()
	move_and_slide(velocity * speed)

func _input(event):         
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(event.relative.x * xSens))
		var value = event.relative.y * xSens
		if value + verRot > -50 and value + verRot < 50:
			verRot += value
			$Camera.rotate_x(deg2rad(value))
