extends Node2D

@export var puzzle_image: Resource

@export_group("Difficulty")
enum Difficulty {EASY, NORMAL, HARD}
@export var difficulty: Difficulty
@export var easy_target_pieces_num = 200
@export var normal_target_pieces_num = 500
@export var hard_target_pieces_num = 1000
@export_group("")

func _ready() -> void:
	create_puzzle_from_image( puzzle_image )


func create_puzzle_from_image( image ):
	
	var puzzle_size = image.get_size()
	var parts_num = null
	
	match difficulty:
		Difficulty.EASY: parts_num = easy_target_pieces_num
		Difficulty.NORMAL: parts_num = normal_target_pieces_num
		Difficulty.HARD: parts_num = hard_target_pieces_num
	
	var target_piece_area = ( puzzle_size.x * puzzle_size.y ) / parts_num
	# we want pieces as square-like as possible
	var target_piece_length = sqrt( target_piece_area )
	
	var parts_in_x = round( puzzle_size.x / target_piece_length )
	var parts_in_y = round( puzzle_size.y / target_piece_length )
	var piece_width = puzzle_size.x / parts_in_x
	var piece_height = puzzle_size.y / parts_in_y
	
	print( "parts_in_x  ", parts_in_x )
	print( "parts_in_y  ", parts_in_y )
	print( "piece_width  ", piece_width )
	print( "piece_height  ", piece_height )
