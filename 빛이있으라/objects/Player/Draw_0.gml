draw_sprite_ext(s_player_shadow, 0, x-12, y+22, 1, -.75, 0, c_white, 0.5);
draw_self();

if(surface_exists(forsurface)){
	draw_surface(forsurface, 0, 0);
}