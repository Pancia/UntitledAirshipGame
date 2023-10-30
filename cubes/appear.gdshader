shader_type spatial;

uniform float appear_progress : hint_range(0, 1.0) = 1.0;
varying float height;

void vertex() {
	height = (VERTEX.y + 0.5) / 1.0;
}

void fragment() {
	ALPHA = mix(1.0, 0.0, abs(height - (appear_progress - 0.99)));
}
