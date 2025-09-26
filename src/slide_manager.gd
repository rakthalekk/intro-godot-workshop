extends Control


@export var start_from_beginning: bool


@onready var slides = $Slides



func _ready() -> void:
	if start_from_beginning:
		slides.current_tab = 0


func _process(_delta: float) -> void:
	_handle_input()


func _handle_input():
	var current_slide = slides.get_current_tab_control() as Slide
	
	if Input.is_action_just_pressed("next_slide"):
		if current_slide.finished_animating:
			_next_slide()
		else:
			current_slide.next_animation()
	elif Input.is_action_just_pressed("previous_slide"):
		if current_slide.default_state:
			_previous_slide()
		else:
			current_slide.previous_animation()
	
	if Input.is_action_just_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _next_slide():
	if slides.current_tab < slides.get_child_count() - 1:
		slides.current_tab += 1


func _previous_slide():
	if slides.current_tab > 0:
		slides.current_tab -= 1
