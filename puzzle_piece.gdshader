shader_type canvas_item;

uniform sampler2D tex;

void fragment() {
	vec4 texColor = texture( tex, UV );
	COLOR = texColor;
}
