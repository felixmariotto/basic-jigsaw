extends Node2D

@export var lock := true
@export var player_ID := 0

var joy_axis = Vector2()

const AXIS_DAMPING = 0.1

func _process(delta: float) -> void:
	
	# update the axis based on the current state of the joypad axis.
	joy_axis.x = Input.get_joy_axis(player_ID, JOY_AXIS_LEFT_X)
	joy_axis.y = Input.get_joy_axis(player_ID, JOY_AXIS_LEFT_Y)
	if joy_axis.x > -AXIS_DAMPING and joy_axis.x < AXIS_DAMPING:
		joy_axis.x = 0.0
	if joy_axis.y > -AXIS_DAMPING and joy_axis.y < AXIS_DAMPING:
		joy_axis.y = 0.0
	
	print( joy_axis )
