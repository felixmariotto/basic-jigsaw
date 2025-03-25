extends HBoxContainer

@export var images: Array[Texture2D]

func _ready() -> void:
	for image in images:
		var textureRect = TextureRect.new()
		textureRect.texture = image
		textureRect.size = Vector2( 20.0, 20.0 )
		textureRect.expand_mode = textureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		add_child( textureRect )
		textureRect.connect( "gui_input", _on_interact_texture_rect.bind(image) )

func _on_interact_texture_rect(event, image):
	if event is InputEventMouseButton and event.pressed:
		restart_puzzle_with_texture(image)

func restart_puzzle_with_texture(image):
	print(image)
