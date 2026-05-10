#region Set Up
	surfMinimapBG = -1;
	surfMinimapEntities = -1;
	h = room_height/6;
	w = room_width/6;
	x = 15;
	y = 15;
#endregion

#region Refreshing Bg
	function RefreshMapBG(argument) {
		surfMinimapBG = surface_create(w,h);
		var _surfTemp = surface_create(room_width, room_height);
		surface_set_target(_surfTemp)
			draw_clear(c_black);
			draw_set_alpha(argument);
			draw_tilemap(layer_tilemap_get_id(layer_get_id("WallTiles")),0,0);
		surface_reset_target();
		surface_set_target(surfMinimapBG);
			draw_surface_stretched(_surfTemp,0,0,w,h);
		surface_reset_target();
		surface_free(_surfTemp);
	}
#endregion

RefreshMapBG(0.5);
