extends Spatial

var perfect = 0;
var hit = 0;
var miss = 0;
var combo = 0;
var best_combo = 0;
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var linesDisplay: Array

enum Pattern { Single, Stair, Ladder }

var patternProg: int
var patternRand: int
var patternArray: Array
const notePrefab = preload("../Scenes/Note.tscn")
var timer = 1

func _ready():
	linesDisplay = [ $Line1/DisplayLine, $Line2/DisplayLine, $Line3/DisplayLine, $Line4/DisplayLine ]

func getPatternArray(pattern: int) -> Array:
	if pattern == Pattern.Single:
		return [rng.randi_range(0, 3)]
	elif pattern == Pattern.Stair:
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
	return []


func _process(delta):
	timer -= delta
	if timer <= 0:
		if patternProg == patternArray.size():
			patternProg = 0
			patternArray = getPatternArray(rng.randi_range(0, 2))
			timer = 0.5
		else:
			var inst = notePrefab.instance()
			inst.translate(Vector3(-1.5 + 1 * patternArray[patternProg], 10.2, -2.0))
			add_child(inst)
			timer = 0.1
			patternProg += 1
	hit = check_note($"Hit Area", hit);
	perfect = check_note($"Perfect Area", perfect);
	update_ui()

func update_ui():
	$HitLabel.text = str(hit);
	$PerfectLabel.text = str(perfect);
	$ComboLabel.text = str(combo);
	$BestComboLabel.text = str(best_combo);

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			for y in 4:
				if Input.is_action_just_pressed("Line_" + str(y)):
					linesDisplay[y].visible = true
					break
		else:
			for y in 4:
				if Input.is_action_just_released("Line_" + str(y)):
					linesDisplay[y].visible = false
					break

func check_note(zone, score):
	var notes = zone.get_overlapping_bodies();
	
	var xOffset = -1.5
	var breakLoop = false
	for note in notes:
		for i in 4:
			if note.translation.x == xOffset + i:
				for y in 4:
					if Input.is_action_pressed("Line_" + str(y)):
						score += 1;
						combo += 1;
						if combo > best_combo:
							best_combo = combo;
						notes.erase(note)
						note.free();
						breakLoop = true
						break
			if breakLoop:
				break
	return(score);

func _on_Miss_Area_body_entered(body):
	if "Note" in body.name:
		miss += 1;
		combo = 0;
		body.free();
		print("miss");
