shader_type canvas_item;
render_mode unshaded;

vec4 texturePointSmooth(sampler2D tex, vec2 uv, vec2 pixel_size) {
	vec2 ddx = dFdx(uv);
	vec2 ddy = dFdy(uv);
	vec2 lxy = sqrt(ddx * ddx + ddy * ddy);
	vec2 uv_pixels = uv / pixel_size;
	vec2 delta_pixel = round(uv_pixels) - vec2(0.5f);
	vec2 uv_dxy_pixels = uv_pixels - delta_pixel;
	uv_dxy_pixels = clamp((uv_dxy_pixels - vec2(0.5f)) * pixel_size / lxy + vec2(0.5f), 0.0f, 1.0f);
	uv = delta_pixel * pixel_size;
	return textureGrad(tex, uv + uv_dxy_pixels * pixel_size, ddx, ddy);
}

void fragment() {
	COLOR = texturePointSmooth(TEXTURE, UV, TEXTURE_PIXEL_SIZE);
}