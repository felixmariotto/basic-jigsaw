extends Node2D

func get_bbox():
	
	var children = get_children()
	var position = children[0].position
	var size = children[0].scale
	var rect2 = Rect2(position, size)
	
	for i in children.size() - 1:
		i += 1
		var child_position = children[0].position
		var child_size = children[0].scale
		rect2.expand( child_position )
		rect2.expand( child_position + child_size )
	
	return rect2
