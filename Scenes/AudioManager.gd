extends Spatial


var DayThemeSound   = preload("res://Sounds/day_theme.wav")
# var NightThemeSound = preload("res://Sounds/night_theme.wav")

func _ready():
	$AudioStreamPlayer.stream = DayThemeSound
	pass


func _process(delta):
	# loop background music
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.play()
	pass
