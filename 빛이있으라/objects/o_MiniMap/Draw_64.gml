if(!surface_exists(surfMinimapBG)) RefreshMapBG();
draw_surface(surfMinimapBG, x, y);

if(!surface_exists(surfMinimapEntities)) surfMinimapEntities = surface_create(w, h);
surface_set_target(surfMinimapEntities);
	draw_clear_alpha(c_black, 0.0);
	with (Player) {
		if(entityOnMinimap == true){
			draw_sprite_ext(s_Pixel_0, 0, Player.x/6, Player.y/6, 4.0, 4.0, 0.0, c_red, 1.0);
		}
	}
	
	with (oKnight) {
		if(entityOnMinimap == true){
			draw_sprite_ext(s_Pixel_1, 0, oKnight.x/6, oKnight.y/6, 4.0, 4.0, 0.0, c_white, 1.0);
		}
	}
	
	with (oArcher) {
		if(entityOnMinimap == true){
			draw_sprite_ext(s_Pixel_2, 0, oArcher.x/6, oArcher.y/6, 4.0, 4.0, 0.0, c_white, 1.0);
		}
	}
	
	with (oTanker) {
		if(entityOnMinimap == true){
			draw_sprite_ext(s_Pixel_3, 0, oTanker.x/6, oTanker.y/6, 4.0, 4.0, 0.0, c_white, 1.0);
		}
	}
	
	with (oBomber) {
		if(entityOnMinimap == true){
			draw_sprite_ext(s_Pixel_4, 0, oBomber.x/6, oBomber.y/6, 4.0, 4.0, 0.0, c_white, 1.0);
		}
	}
	
	with (Portal) {
		if(entityOnMinimap == true){
			draw_sprite_ext(s_Pixel_5, 0, Portal.x/6, Portal.y/6, 8.0, 8.0, 0.0, c_purple, 1.0);
		}
	}
surface_reset_target();
draw_surface(surfMinimapEntities, x, y);