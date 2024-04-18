// Draw pause text
if (global.gameSpeed == 0
	&& !mouse_check_button(mb_right))
{
	var _windowWidth = window_get_width();
	var _windowHeight = window_get_height();
	var _font = draw_get_font();
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	DrawTextShadow(
		round(_windowWidth * 0.5), _windowHeight - 16,
		"PAUSE",
		c_white, c_black, dsin(current_time * 0.5) * 0.5 + 0.5);
	draw_set_halign(fa_left);
	draw_set_font(_font);
}
