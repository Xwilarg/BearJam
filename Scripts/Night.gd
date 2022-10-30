extends Spatial

var score = 0
var combo = 0;
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var linesDisplay: Array
var gd = GameSytem

var patternProg: int
var patternRand: int
var patternArray: Array
var currPattern: int
const notePrefab = preload("../Scenes/Note.tscn")
var timer = 1

var burst = 0

var comboLabel: Object

var allNotes = []

func _ready():
	linesDisplay = [ $Line1/DisplayLine, $Line2/DisplayLine, $Line3/DisplayLine, $Line4/DisplayLine ]
	comboLabel = $ComboLabel

enum Pattern { Stair, Ladder, Funnel }

func getPatternArray(pattern: int) -> Array:
	if pattern == Pattern.Stair:
		if rng.randi_range(0, 1) == 0:
			return [0, 1, 2, 3]
		return [3, 2, 1, 0]
	elif pattern == Pattern.Ladder:
		var rand = rng.randi_range(0, 5)
		if rand == 0: return [0, 1, 0, 1]
		elif rand == 1: return [1, 2, 1, 2]
		elif rand == 2: return [2, 3, 2, 3]
		elif rand == 3: return [3, 2, 3, 2]
		elif rand == 4: return [2, 1, 2, 1]
		else: return [1, 0, 1, 0]
	elif pattern == Pattern.Funnel:
		if rng.randi_range(0, 1) == 0:
			return [0, 3, 1, 2, 0, 3]
		return [1, 2, 0, 3, 1, 2]
	return []

func getWaitingTime(pattern: int) -> int:
	if pattern == Pattern.Funnel:
		return 0 if patternProg % 2 == 1 else 1
	return 1

func getPatternMaxSize() -> int: return 3

func getYDistance(obj) -> int:
	var p = obj.global_transform.origin.y - 1
	return -p if p < 0 else p

func spawnNote():
	var inst = notePrefab.instance()
	currPattern = patternArray[patternProg]
	inst.translate(Vector3(-1.5 + 1 * currPattern, 10.2, -2.0))
	add_child(inst)
	allNotes.push_back(inst)
	patternProg += 1

func _process(delta):
	timer -= delta
	if timer <= 0:
		if patternProg == patternArray.size():
			patternProg = 0
			patternArray = getPatternArray(rng.randi_range(0, getPatternMaxSize()))
			if burst > 0:
				timer = 0
				burst -= 1
			else:
				burst = rng.randi_range(0, gd.maxBurst)
				timer = gd.delayBetweenNotes * 5.0
		else:
			while true:
				spawnNote()
				#if getWaitingTime(currPattern) == 1:
				break
			timer = gd.delayBetweenNotes
	
	var xOffset = -1.5

	for i in 4:
		if Input.is_action_just_pressed("Line_" + str(i)):
			for note in allNotes:
				if note.translation.x == xOffset + i:
					var dist = getYDistance(note)
					if dist < gd.permissiveness:
						score += 1;
						combo += 1;
					elif dist < 2:
						combo = 0
					else:
						break
					allNotes.erase(note)
					note.free();
					break
	update_ui()

func update_ui():
	comboLabel.text = "" if combo < 10 else str(combo)

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			for y in 4:
				if Input.is_action_just_pressed("Line_" + str(y)):
					linesDisplay[y].visible = true
		else:
			for y in 4:
				if Input.is_action_just_released("Line_" + str(y)):
					linesDisplay[y].visible = false

func _on_Miss_Area_body_entered(body):
	if "Note" in body.name:
		combo = 0;
		allNotes.erase(body)
		body.free();
