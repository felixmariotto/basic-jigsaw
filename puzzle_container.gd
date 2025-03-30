extends Node2D

@export var puzzle_image: Resource

@export_group("Difficulty")
enum Difficulty {EASY, NORMAL, HARD}
@export var difficulty: Difficulty
@export var easy_target_pieces_num = 200
@export var normal_target_pieces_num = 500
@export var hard_target_pieces_num = 1000
@export var easy_fitting_tolerence = 12.0
@export var normal_fitting_tolerence = 10.0
@export var hard_fitting_tolerence = 8.0
@export_group("")

var PuzzlePiece = preload("res://puzzle_piece.tscn")
var PuzzleChunk = preload("res://puzzle_chunk.tscn")
var puzzle_chunks = []

func _ready() -> void:
	create_puzzle_from_image( puzzle_image )

# create pieces and one chunk for each piece, and lay them out on the table.
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
			piece.release.connect(handle_release)
			
			# add the piece to a chunk, so that chunks of pieces can later be merged to assemble the puzzle
			var puzzle_chunk = PuzzleChunk.instantiate()
			puzzle_chunk.add_child( piece )
			add_child( puzzle_chunk )
			puzzle_chunks.append( puzzle_chunk )
	
	shuffle()

func shuffle():
	var viewport_rect = get_viewport_rect()
	for chunk in puzzle_chunks:
		# bounding box of this chunk
		var chunk_bbox = chunk.get_bbox()
		chunk.position.x += randf_range( viewport_rect.position.x - chunk_bbox.position.x, viewport_rect.size.x - chunk_bbox.position.x - chunk_bbox.size.x )
		chunk.position.y += randf_range( viewport_rect.position.y - chunk_bbox.position.y, viewport_rect.size.y - chunk_bbox.position.y - chunk_bbox.size.y )
		
# upon release of a puzzle piece, attempt to assemble chunks of puzzle.
# this is a recursive function that's meant to be re-called from inside itself as soon as a fit
# is found between two chunks. This allows several fitting to occur at the same time, in case
# a piece is dropped between two pieces that could fit with it.
func handle_release():
	
	var base_list_size = puzzle_chunks.size()
	var new_chunks_list = []
	var fitting_tolerence = null
	
	match difficulty:
		Difficulty.EASY: fitting_tolerence = easy_fitting_tolerence
		Difficulty.NORMAL: fitting_tolerence = normal_fitting_tolerence
		Difficulty.HARD: fitting_tolerence = hard_fitting_tolerence
	
	for i in base_list_size:
		
		var base_chunk = puzzle_chunks[i]
		
		for j in base_list_size - i - 1:
			j += i + 1
			
			var tested_chunk = puzzle_chunks[j]
			
			if base_chunk.position.distance_to( tested_chunk.position ) < fitting_tolerence:
				base_chunk.merge_with( tested_chunk )
