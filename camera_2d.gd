extends Camera2D

@export var min_zoom := 0.5
@export var max_zoom := 2.0
@export var zoom_wheel_and_and_down_steps := 5

var is_dragging = false
var drag_start_viewport_pos := Vector2()
var drag_start_camera_pos := Vector2()
var current_zoom_level : int

func _ready() -> void:
	set_zoom_level( 0 )

func try_increase_zoom():
	if current_zoom_level > zoom_wheel_and_and_down_steps * -1:
		set_zoom_level( current_zoom_level - 1 )

func try_decrease_zoom():
	if current_zoom_level < zoom_wheel_and_and_down_steps:
		set_zoom_level( current_zoom_level + 1 )

func set_zoom_level( new ):
	current_zoom_level = new
	update_camera_zoom()

func update_camera_zoom():
	var weight = float(current_zoom_level + zoom_wheel_and_and_down_steps) / float(zoom_wheel_and_and_down_steps * 2)
	var target_zoom = lerp(min_zoom, max_zoom, weight)
	zoom.x = target_zoom
	zoom.y = target_zoom

func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
	
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			try_increase_zoom()
			
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			try_decrease_zoom()
		
		elif event.button_index == MOUSE_BUTTON_LEFT:
			
			if event.pressed:
				is_dragging = true
				drag_start_viewport_pos = event.position
				drag_start_camera_pos = position
			
			elif not event.pressed:
				is_dragging = false
	
	elif event is InputEventMouseMotion and is_dragging:
		var offset = drag_start_viewport_pos - event.position
		position = drag_start_camera_pos + offset / zoom.x

# connected from PuzzlePiece's script when instantiated
func _on_puzzle_piece_picked():
	is_dragging = false
