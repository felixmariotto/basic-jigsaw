extends Area2D

@export var texture: Resource
@export var size: Vector2
@export var offset: Vector2
@export var coordinate: Vector2
@export var grid_size: Vector2


#######

func setup():
	
	# Create a quad mesh
	$MeshInstance2D.mesh = get_quad_mesh()
	
	# Set the shader uniforms
	$MeshInstance2D.material.set_shader_parameter( 'tex', texture )
	
	# Set the piece position
	position = offset
	scale = size
	
########

func get_quad_mesh():
	
	var my_mesh = ArrayMesh.new()

	# Define vertex format (Position + UV)
	var arrays = []
	arrays.resize( Mesh.ARRAY_MAX )

	# Define vertices (quad corners)
	var vertices = PackedVector3Array([
		Vector3(0, 0, 0),
		Vector3(1, 0, 0),
		Vector3(1, 1, 0),
		Vector3(0, 1, 0)
	])

	# Define UVs (custom UV mapping)
	var uvs = PackedVector2Array([
		coordinate / grid_size,
		Vector2(coordinate.x / grid_size.x + 1.0 / grid_size.x, coordinate.y / grid_size.y),
		coordinate / grid_size + Vector2(1.0, 1.0) / grid_size,
		Vector2(coordinate.x / grid_size.x, coordinate.y / grid_size.y + 1.0 / grid_size.y)
	])

	# Define indices (order in which vertices are connected)
	var indices = PackedInt32Array([
		0, 1, 2,  0, 2, 3
	])

	# Assign to array
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_INDEX] = indices

	# Create mesh surface
	my_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)

	return my_mesh
