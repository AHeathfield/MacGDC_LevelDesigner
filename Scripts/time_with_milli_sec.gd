extends CanvasLayer

@onready var label: Label = $Panel/MarginContainer/Label

var current_time: float = 0.0

static func convert_time_to_string(time: float) -> String:
	var hours: int = int(time / (60.0 * 60.0))
	var minutes: int = int(time / 60.0) % 60
	var seconds: int = int(time) % 60
	var miliseconds: int = int(time * 1000.0) % 1000
	var string: String = "%02d.%03d" % [seconds, miliseconds]
	if minutes > 0 or hours > 0:
		string = string.insert(0, ("%02d:" if hours > 0 else "%02d:") % minutes)
	if hours > 0:
		string = string.insert(0, "%d:" % hours)
	return string
