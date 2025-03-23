extends Node2D

@export var puzzle_image: Resource

@export_group("Difficulty")
enum Difficulty {EASY, NORMAL, HARD}
@export var difficulty: Difficulty
@export var easy_target_pieces_num = 200
@export var normal_target_pieces_num = 500
@export var hard_target_pieces_num = 1000
@export_group("")

var PuzzlePiece = preload("res://puzzle_piece.tscn")

func _ready() -> void:
	create_puzzle_from_image( puzzle_image )


func create_puzzle_from_image( image ):
	
	# Compute the size of the parts, and the number of parts in each rows and column of the puzzle.
	
	var puzzle_size = image.get_size()
	var parts_num = null
	
	match difficulty:
		Difficulty.EASY: parts_num = easy_target_pieces_num
		Difficulty.NORMAL: parts_num = normal_target_pieces_num
		Difficulty.HARD: parts_num = hard_target_pieces_num
	
	var target_piece_area = ( puzzle_size.x * puzzle_size.y ) / parts_num
	# we want pieces as square-like as possible
	var target_piece_length = sqrt( target_piece_area )
	
	var pieces_in_x = round( puzzle_size.x / target_piece_length )
	var pieces_in_y = round( puzzle_size.y / target_piece_length )
	var piece_width = puzzle_size.x / pieces_in_x
	var piece_height = puzzle_size.y / pieces_in_y
	
	# Instantiate each piece
	
	for ix in pieces_in_x:
		for iy in pieces_in_y:
			var piece = PuzzlePiece.instantiate()
			piece.texture = puzzle_image
			piece.size = Vector2( piece_width, piece_height )
			piece.offset = Vector2( ( puzzle_size.x / pieces_in_x ) * ix, ( puzzle_size.y / pieces_in_y ) * iy )
			piece.coordinate = Vector2( ix, iy )
			piece.grid_size = Vector2( pieces_in_x, pieces_in_y )
			piece.setup()
			add_child( piece )
