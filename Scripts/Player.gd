extends KinematicBody

var verRot: float
var speed = 12
var xSens = -1.0
var label: Object

var objTarget: Object

enum ResourceType { WOOD, ROCK }

var actionCounter = 0
var objLabels : Array
var resources : Array
var labelText: Array


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	label = get_node("Label")
	objLabels = [ $Inventory/VBoxContainer/WoodLabel, $Inventory/VBoxContainer/RockLabel ]
	resources = [ 0, 0 ]
	labelText = [ "Wood: ", "Rock: " ]

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

	var target = $Camera/RayCast.get_collider();
	if target:
		if "Tree" in target.name:
			label.show()
			label.set_text("Spam Spacebar")
			objTarget = target
			if Input.is_action_pressed("action_spacebar"):
				actionCounter += 1
				if actionCounter == 20:
					resources[ResourceType.WOOD] += 1
					objTarget.free()
					reset()
					updateUI()
		else:
			reset()
	else:
		reset()

func emptyResource(type: int) -> int:
	var count = resources[type]
	resources[type] = 0
	updateUI()
	return count

func updateUI():
	for i in resources.size():
		objLabels[i].text = labelText[i] + str(resources[i])

func reset():
	label.hide()
	objTarget = null
	actionCounter = 0

func _input(event):         
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(event.relative.x * xSens))
		var value = event.relative.y * xSens
		if value + verRot > -50 and value + verRot < 50:
			verRot += value
			$Camera.rotate_x(deg2rad(value))
