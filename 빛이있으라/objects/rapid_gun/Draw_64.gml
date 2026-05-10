if(is_being_carried){
	draw_text(400,50, "rapid_gun");
	if(remain_ammo <= 0){
		draw_text_color(400, 100, "No Ammo",  c_red, c_red, c_red, c_red,1);
	}
	
	if(loading == true){
		draw_text_color(400, 120, "Reloading", c_red, c_red, c_red, c_red, 1);
	}
	draw_text(400, 150, "Ammo :"+string(remain_ammo)+"/"+string(magazine));
}