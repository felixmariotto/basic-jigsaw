extends HBoxContainer

@export var images: Array[Texture2D]

signal picked_new_puzzle

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
	picked_new_puzzle.emit(image)

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		get_parent().visible = not get_parent().visible
