extends Spatial

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
var timerLabel: Object

var nbMiss: int
var nbBad: int
var nbGood: int
var nbGreat: int

var scoreMiss: Object
var scoreBad: Object
var scoreGood: Object
var scoreGreat: Object

var allNotes = []

var musicTimer: float

func _ready():
	scoreMiss = $Score/Miss
	scoreBad = $Score/Bad
	scoreGood = $Score/Good
	scoreGreat = $Score/Great
	
	linesDisplay = [ $Line1/DisplayLine, $Line2/DisplayLine, $Line3/DisplayLine, $Line4/DisplayLine ]
	comboLabel = $ComboLabel
	timerLabel = $TimerLabel
	musicTimer = GameSytem.songDuration

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
	musicTimer -= delta
	timerLabel.text = "%.2f" % musicTimer
	if musicTimer <= 0.0:
		pass # End of the game

	timer -= delta
	if timer <= 0.0:
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
						nbGreat += 1;
						combo += 1;
					elif dist < gd.permissiveness * 2.0:
						nbGood += 1;
						combo += 1;
					elif dist < gd.permissiveness * 3.0:
						nbBad += 1
						combo = 0
					elif dist < gd.permissiveness * 4.0:
						nbMiss += 1
						combo = 0
					else:
						break
					allNotes.erase(note)
					note.free();
					break
	update_ui()

func update_ui():
	comboLabel.text = "" if combo < 10 else str(combo)
	scoreGreat.text = str(nbGreat)
	scoreGood.text = str(nbGood)
	scoreBad.text = str(nbBad)
	scoreMiss.text = str(nbMiss)

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
