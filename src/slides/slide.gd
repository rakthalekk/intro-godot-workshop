class_name Slide
extends ColorRect

@export var animations: Array[String]

var animating = false

var default_state = true
var finished_animating = false

var next_animation_index = 0

@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	if animations.size() == 0:
		finished_animating = true


func next_animation():
	# If already in an animation, fast-forward to the end
	if animating:
		animating = false
		anim_player.advance(99)
		increment_animation()
		return
	
	if next_animation_index >= animations.size():
		printerr("Animation index %d out of bounds for size %d" % [next_animation_index, animations.size()])
		return
	
	var next_anim = animations[next_animation_index]
	
	if anim_player.has_animation(next_anim):
		anim_player.play(next_anim)
	else:
		printerr("Animation with name %s does not exist" % next_anim)
		return
	
	animating = true
	await anim_player.animation_finished
	
	# If the animation has not been canceled, increment the animation
	if animating:
		increment_animation()


func previous_animation():
	# If already in an animation, rewind to the beginning
	if animating:
		animating = false
		anim_player.stop()
		anim_player.seek(0)
		anim_player.advance(0)
		
		if next_animation_index == 0:
			default_state = true
		
		return
	
	if next_animation_index <= 0:
		printerr("Animation index %d out of bounds" % next_animation_index)
		return
	
	decrement_animation()
	
	var next_anim = animations[next_animation_index]
	
	if anim_player.has_animation(next_anim):
		anim_player.play_backwards(next_anim)
	else:
		printerr("Animation with name %s does not exist" % next_anim)
		return
	
	animating = true
	await anim_player.animation_finished
	animating = false
	
	if next_animation_index == 0:
		default_state = true


func increment_animation():
	animating = false
	default_state = false
	
	next_animation_index += 1
	
	if next_animation_index >= animations.size():
		finished_animating = true


func decrement_animation():
	animating = false
	finished_animating = false
	
	next_animation_index -= 1
