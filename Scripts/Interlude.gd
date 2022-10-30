extends Spatial

func _ready():
	var woodLabel = $HBoxContainer/VBoxContainer/HBoxContainer/Shield/VBoxContainer/Label
	var rockLabel = $HBoxContainer/VBoxContainer/HBoxContainer3/Tower/VBoxContainer/Label
	var scrapLabel = $HBoxContainer/VBoxContainer/HBoxContainer/Sound/VBoxContainer/Label
	var candyLabel = $HBoxContainer/VBoxContainer/HBoxContainer3/Light/VBoxContainer/Label
	woodLabel.text = "City defense: " + str(GameSytem.wood()) + " pieces of wood,\nsong will last " + str(GameSytem.songDuration) + " seconds"
	rockLabel.text = "Towers: " + str(GameSytem.rock()) + " rocks,\nmax number of pattern bursts of " + str(GameSytem.maxBurst)
	scrapLabel.text = "Speakers: " + str(GameSytem.scrap()) + " scraps,\ndelay between notes of " + str(GameSytem.delayBetweenNotes) + " seconds"
	candyLabel.text = "Spotlights: " + str(GameSytem.candy()) + " candies,\ndistance to hit a note of " + ("%.2f" % GameSytem.permissiveness) + " cm"

func _on_Button_pressed():
	GameSytem.go_to_scene("res://Scenes/Night.tscn");
