extends HBoxContainer

@export var images: Array[Texture2D]

signal picked_new_puzzle

var current_joypad_pick = null
var picking_is_locked = false

func _ready() -> void:
	for image in images:
		var textureRect = TextureRect.new()
		textureRect.texture = image
		textureRect.expand_mode = textureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		add_child( textureRect )
		textureRect.connect( "gui_input", _on_interact_texture_rect.bind(image) )

func _process(delta: float) -> void:
	# move the arrow toward its target position
	if picking_is_locked and current_joypad_pick != null:
		#
		var arrow = get_parent().get_node("Arrow")
		var arrow_rect = arrow.get_rect()
		#
		var target_image = get_children()[current_joypad_pick]
		var target_image_rect = target_image.get_rect()
		var target_x_pos = target_image.get_global_position().x + (target_image_rect.size.x * 0.5) - (arrow_rect.size.x * 0.5)
		#
		var offset = ( target_x_pos - arrow.position.x ) * 0.3
		arrow.position.x += offset
		#
		if abs(offset) < 0.1:
			arrow.position.x = target_x_pos
			picking_is_locked = false

func _on_interact_texture_rect(event, image):
	if event is InputEventMouseButton and event.pressed:
		restart_puzzle_with_texture(image)

func restart_puzzle_with_texture(image):
	picked_new_puzzle.emit(image)

func set_joypad_pick( new_pick_direction ):
	var arrow = get_parent().get_node("Arrow")
	arrow.visible = true
	picking_is_locked = true
	if current_joypad_pick == null:
		current_joypad_pick = 0
	else :
		current_joypad_pick = int( min( images.size() - 1, max( 0, current_joypad_pick + new_pick_direction ) ) )

func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		get_parent().visible = not get_parent().visible
	
	elif get_parent().visible :
		
		if event is InputEventJoypadMotion and event.axis == JOY_AXIS_LEFT_X and not picking_is_locked:
			if abs(event.axis_value) < 0.1 : return
			var tap_direction = sign(event.axis_value)
			set_joypad_pick( tap_direction )
	
		if event is InputEventJoypadButton and event.button_index == JOY_BUTTON_A and event.pressed and current_joypad_pick != null:
			restart_puzzle_with_texture(images[current_joypad_pick])
