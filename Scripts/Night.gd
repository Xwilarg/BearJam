extends Spatial

var perfect = 0;
var hit = 0;
var miss = 0;
var combo = 0;
var best_combo = 0;

func _ready():
	pass

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
	
	var xOffset = -1.5
	for i in 4:
		for note in notes:
			if note.translation.x == xOffset + i:
				for y in 4:
					if Input.is_action_pressed("Line_" + str(y)):
						score += 1;
						combo += 1;
						if combo > best_combo:
							best_combo = combo;
						notes.erase(note)
						note.free();
	return(score);

func _on_Miss_Area_body_entered(body):
	if "Note" in body.name:
		miss += 1;
		combo = 0;
		body.free();
		print("miss");
