extends KinematicBody

var verRot: float
var speed = 12
var xSens = -1.0
var label: Object

var objTarget: Object

enum ResourceType { WOOD, ROCK, SCRAP, CANDY}

var actionCounter = 0
var objLabels : Array
var resources : Array
var labelText: Array
var woodcutting = -1;


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	label = get_node("Label")
	objLabels = [ $Inventory/VBoxContainer/WoodLabel, $Inventory/VBoxContainer/RockLabel, $Inventory/VBoxContainer/ScrapLabel, $Inventory/VBoxContainer/CandyLabel, $Inventory/VBoxContainer/TimeLabel ]
	resources = [ 0, 0, 0, 0, 0]
	labelText = [ "Wood: ", "Rock: ", "Scrap: ", "Candy: ", "Time left: "  ]

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
			label.set_text("Spam K and L to cut down")
			objTarget = target
			if Input.is_action_just_pressed("Line_2") && woodcutting == -1 || Input.is_action_just_pressed("Line_3") && woodcutting == 1:
				actionCounter += 1;
				woodcutting *= -1;
				if actionCounter == 5:
					resources[ResourceType.WOOD] += 1
					objTarget.free()
					reset()
		elif "Waste" in target.name:
			label.show()
			label.set_text("Spam Space to clean up")
			objTarget = target
			if Input.is_action_just_pressed("action_spacebar"):
				actionCounter += 1
				if actionCounter == 3:
					resources[ResourceType.SCRAP] += 1
					objTarget.free()
					reset()
		elif "Rock" in target.name:
			label.show()
			label.set_text("Hold Spacebar to grab it with claws")
			objTarget = target
			if Input.is_action_pressed("action_spacebar"):
				actionCounter += 1
				if actionCounter == 30:
					resources[ResourceType.ROCK] += 1
					objTarget.free()
					reset()
		elif "Candy" in target.name:
			label.show()
			label.set_text("Space: Pickup")
			objTarget = target
			if Input.is_action_just_pressed("action_spacebar"):
				$CollectCandy.play()  
				resources[ResourceType.CANDY] += 1
				objTarget.free()
				reset()
	else:
		reset()
	updateUI()

func emptyResource(type: int) -> int:
	var count = resources[type]
	resources[type] = 0
	updateUI()
	return count

func updateUI():
	resources[4] = int(get_parent().get_time_left());
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
