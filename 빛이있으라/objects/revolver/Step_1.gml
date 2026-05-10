#region Being Carried
	if(is_being_carried){
		direction = point_direction(x, y, mouse_x, mouse_y);
		image_angle = direction;
		if(mouse_x - x < 0){
			image_yscale = -1;
			image_xscale = -1;
			
		}
		else if(mouse_x - x > 0){
			image_yscale = 1;
			image_xscale = -1;
		}
		
		if(target != noone){
			x = target.x;
			y = target.y;
		}
	}
#endregion
