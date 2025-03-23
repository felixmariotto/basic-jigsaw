extends HBoxContainer

@export var images: Array[Texture2D]

func _ready() -> void:
	for image in images:
		var textureRect = TextureRect.new()
		textureRect.texture = image
		textureRect.size = Vector2( 20.0, 20.0 )
		add_child( textureRect )
