extends Area2D

@export var texture: Resource
@export var width: int
@export var height: int
@export var offset: Vector2
@export var coordinate: Vector2
@export var grid_size: Vector2

func setup():
	
	# Set piece size
	$CollisionShape2D.shape.size = Vector2( width, height )
	$ColorRect.custom_minimum_size = Vector2( width, height )
	
	# Set the shader uniforms
	$ColorRect.material.set_shader_parameter( 'tex', texture )
	$ColorRect.material.set_shader_parameter( 'coordinate', coordinate )
	$ColorRect.material.set_shader_parameter( 'grid_size', grid_size )
	print( coordinate / grid_size )
	# Set the piece position
	position = offset
	
"""
piece.texture = puzzle_image
piece.width = piece_width
piece.height = piece_height
piece.offset = Vector2( ( puzzle_siz
"""
