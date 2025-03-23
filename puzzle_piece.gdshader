shader_type canvas_item;

uniform sampler2D tex;
uniform vec2 coordinate;
// number of pieces in each direction.
uniform vec2 grid_size;

void fragment() {
	
	vec2 modifUV = UV;
	modifUV /= grid_size;
	modifUV += coordinate / grid_size;
	
	vec4 texColor = texture( tex, modifUV );
	
	COLOR = texColor;
	// COLOR = vec4( modifUV, 0.0, 1.0 );
}
