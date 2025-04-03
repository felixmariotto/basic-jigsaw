extends Camera2D

var is_dragging = false
var drag_start_viewport_pos := Vector2()
var drag_start_camera_pos := Vector2()

func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.pressed:
		is_dragging = true
		drag_start_viewport_pos = event.position
		drag_start_camera_pos = position
	
	elif event is InputEventMouseButton and not event.pressed:
		is_dragging = false
	
	elif event is InputEventMouseMotion and is_dragging:
		var offset = drag_start_viewport_pos - event.position
		position = drag_start_camera_pos + offset

func _on_puzzle_piece_picked():
	is_dragging = false
