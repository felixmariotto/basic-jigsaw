extends Node2D

var PuzzleContainer = preload("res://puzzle_container.tscn")

func _ready() -> void:
	$GUI/PuzzleSelector.connect("picked_new_puzzle", start_new_puzzle)

func start_new_puzzle(texture):
	var puzzle_container = PuzzleContainer.instantiate()
	puzzle_container.puzzle_image = texture
	$PuzzleArea.add_child( puzzle_container )
	$GUI.visible = false

func _unhandled_input(event: InputEvent) -> void:
	"""
	if event is InputEventMouseButton:
		print("is pressed: ", event.pressed)
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("mouse button is left")
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			print("button is right")
	
	if event is InputEventMouseMotion:
		print("new position: ", event.position)
	"""
