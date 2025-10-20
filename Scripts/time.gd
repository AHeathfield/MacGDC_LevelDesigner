extends CanvasLayer

@onready var second_timer = $Timer
@onready var label: Label = $Panel/MarginContainer/Label

var elapsed_time := 0 # Total amount of time in seconds

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_timer()
	second_timer.start()


func update_timer() -> void:
	@warning_ignore("integer_division")
	var minutes = elapsed_time / 60
	var seconds = elapsed_time % 60
	label.text ="Time - " + str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)


func _on_timer_timeout() -> void:
	elapsed_time += 1
	update_timer()
