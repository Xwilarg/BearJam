extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var perfect = 0;
var hit = 0;
var miss = 0;
var combo = 0;
var best_combo = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	hit = check_note($"Hit Area", hit);
	perfect = check_note($"Perfect Area", perfect);
	update_ui();
	pass

func update_ui():
	$HitLabel.text = str(hit);
	$PerfectLabel.text = str(perfect);
	$ComboLabel.text = str(combo);
	$BestComboLabel.text = str(best_combo);

func check_note(zone, score):
	var notes = zone.get_overlapping_bodies();
	
	for note in notes:
		if note.translation.x == -1.5:
			if Input.is_action_pressed("Red"):
				score += 1;
				combo += 1;
				if combo > best_combo:
					best_combo = combo;
				note.free();
			print("gauche");
		elif note.translation.x == -0.5:
			if Input.is_action_pressed("Blue"):
				score += 1;
				combo += 1;
				if combo > best_combo:
					best_combo = combo;
				note.free();
			print("centre gauche");
		elif note.translation.x == 0.5:
			if Input.is_action_pressed("Green"):
				score += 1;
				combo += 1;
				if combo > best_combo:
					best_combo = combo;
				note.free();
			print("centre droite");
		elif note.translation.x == 1.5:
			if Input.is_action_pressed("Yellow"):
				score += 1;
				combo += 1;
				if combo > best_combo:
					best_combo = combo;
				note.free();
			print("droite");
	return(score);

func _on_Miss_Area_body_entered(body):
	if "Note" in body.name:
		miss += 1;
		combo = 0;
		body.free();
		print("miss");
