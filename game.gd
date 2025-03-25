extends Node2D

var PuzzleContainer = preload("res://puzzle_container.tscn")

func _ready() -> void:
	$GUI/PuzzleSelector.connect("picked_new_puzzle", start_new_puzzle)

func start_new_puzzle(texture):
	var puzzle_container = PuzzleContainer.instantiate()
	puzzle_container.puzzle_image = texture
	add_child( puzzle_container )
	$GUI.visible = false
