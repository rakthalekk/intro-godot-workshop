extends Control


@export var start_from_beginning: bool


@onready var slides = $Slides



func _ready() -> void:
	if start_from_beginning:
		slides.current_tab = 0


func _process(_delta: float) -> void:
	_handle_input()


func _handle_input():
	if Input.is_action_just_pressed("next_slide"):
		if slides.current_tab < slides.get_child_count() - 1:
			slides.current_tab += 1
	elif Input.is_action_just_pressed("previous_slide"):
		if slides.current_tab > 0:
			slides.current_tab -= 1
	
	if Input.is_action_just_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
