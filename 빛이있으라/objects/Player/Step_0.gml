#region Movement
	var _x_input = keyboard_check(key_right) - keyboard_check(key_left);
	var _y_input = keyboard_check(key_down) - keyboard_check(key_up);
	
	//var _x_input = keyboard_check(vk_right) - keyboard_check(vk_left);
	//var _y_input = keyboard_check(vk_down) - keyboard_check(vk_up);
	
	x_speed_ += _x_input * acceleration_;
	y_speed_ += _y_input * acceleration_;
		
var _speed = point_distance(0, 0, x_speed_, y_speed_);
var _direction = point_direction(0, 0, x_speed_, y_speed_);
if (_speed > max_speed_) {
	x_speed_ = lengthdir_x(max_speed_, _direction);
	y_speed_ = lengthdir_y(max_speed_, _direction);
}

if (_x_input == 0) {
	x_speed_ = lerp(x_speed_, 0, .3);
}
if (_y_input == 0) {
	y_speed_ = lerp(y_speed_, 0, .3);
}

if (_x_input == 0 && _y_input == 0) {
	image_speed = 0;
	image_index = 0;
} else {
	image_speed = .7;	
}

if (mouse_x - x > 0) {
	image_xscale = -1;	
} else if (mouse_x - x < 0) {
	image_xscale = 1;	
}


// Move horizontally
x += x_speed_;

// Right collisions
if x_speed_ > 0 {
	if (grid_meeting()) {
		x = bbox_right&~(CELL_WIDTH-1);
		x -= bbox_right-x;
		x_speed_ = 0;
	}
} else if x_speed_ < 0 {
	// Left collisions
	if (grid_meeting()) {
		x = bbox_left&~(CELL_WIDTH-1);
		x += CELL_WIDTH+x-bbox_left;
		x_speed_ = 0;
	}
}

// Move vertically
y += y_speed_;

// Vertical collisions
if y_speed_ > 0 {
	// Bottom collisions
	if (grid_meeting()) {
		y = bbox_bottom&~(CELL_HEIGHT-1);
		y -= bbox_bottom-y;
		y_speed_ = 0;
	}
} else if y_speed_ < 0 {
	// Top collisions
	if (grid_meeting()) {
		y = bbox_top&~(CELL_HEIGHT-1);
		y += CELL_HEIGHT+y-bbox_top;
		y_speed_ = 0;
	}
}

if(Player.hp <= 0){
	max_speed_ = 0;
	restart = true;
    if (keyboard_check_pressed(vk_space))
    {
        room_goto(Start);
    }
}
#endregion

#region Pickup Weapons
	if(keyboard_check_pressed(key_pickup)){
		var pickupList = ds_list_create();
		var pickupCount = collision_circle_list(x ,y ,pickup_radius ,long_gun ,false ,true ,pickupList, true)
						+ collision_circle_list(x ,y ,pickup_radius ,shot_gun ,false ,true ,pickupList, true)
						+ collision_circle_list(x ,y ,pickup_radius ,rapid_gun ,false ,true ,pickupList, true)
						+ collision_circle_list(x ,y ,pickup_radius ,sling_shot ,false ,true ,pickupList, true)
						+ collision_circle_list(x ,y ,pickup_radius ,crossbow ,false ,true ,pickupList, true)
						+ collision_circle_list(x ,y ,pickup_radius ,revolver ,false ,true ,pickupList, true)
						+ collision_circle_list(x ,y ,pickup_radius ,sniper ,false ,true ,pickupList, true)
						+ collision_circle_list(x ,y ,pickup_radius ,rpg ,false ,true ,pickupList, true)
		
		if(pickupCount > 0){
			
			if(weapon == noone){
				weapon = pickupList[| 0];
				weapon.target = id;
				weapon.is_being_carried = true;
			}else{
				for(var index = 0; index < pickupCount; index++){
					if(pickupList[| index] != weapon){
						weapon.target = noone;
						weapon.is_being_carried = false;
						
						weapon = pickupList[| index];
						weapon.target = id;
						weapon.is_being_carried = true;
						
						break;
					}
				}
			}
		}
		ds_list_destroy(pickupList);
	}
	
#endregion

#region FoV
	surface_set_target(forsurface);
	
	draw_set_color(c_white);
	draw_set_alpha(0.3);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_alpha(1);
	
	gpu_set_blendmode(bm_subtract);
	
	with(wall){
		draw_set_color(c_black);
		
		draw_primitive_begin(pr_trianglestrip);
		
			draw_vertex(bbox_left, bbox_top);
			var dir = point_direction(Player.x, Player.y, bbox_left, bbox_top);
			draw_vertex(x + lengthdir_x(Player.shadowsize, dir), y + lengthdir_y(Player.shadowsize, dir));
			
			draw_vertex(bbox_left, bbox_bottom);
			var dir = point_direction(Player.x, Player.y, bbox_left, bbox_bottom);
			draw_vertex(x + lengthdir_x(Player.shadowsize, dir), y + lengthdir_y(Player.shadowsize, dir));
			
			draw_vertex(bbox_right, bbox_top);
			var dir = point_direction(Player.x, Player.y, bbox_right, bbox_top);
			draw_vertex(x + lengthdir_x(Player.shadowsize, dir), y + lengthdir_y(Player.shadowsize, dir));
			
			draw_vertex(bbox_right, bbox_bottom);
			var dir = point_direction(Player.x, Player.y, bbox_right, bbox_bottom);
			draw_vertex(x + lengthdir_x(Player.shadowsize, dir), y + lengthdir_y(Player.shadowsize, dir));
			
			draw_vertex(bbox_left, bbox_top);
			draw_vertex(bbox_left, bbox_bottom);
			draw_vertex(bbox_right, bbox_top);
			
			draw_vertex(bbox_right, bbox_top);
			draw_vertex(bbox_left, bbox_bottom);
			draw_vertex(bbox_right, bbox_bottom);
			
		draw_primitive_end();
	}
	/*
	look_dir = point_direction(x, y, mouse_x, mouse_y);
	draw_primitive_begin(pr_trianglefan);
		draw_vertex(x, y);
		
		var fovarcprocessed = fovarc/10
		for(i = 0; i <= 36 - fovarcprocessed; i++){
			xx = lengthdir_x(1000, (i*10)+look_dir+(fovarc/2));
			yy = lengthdir_y(1000, (i*10)+look_dir+(fovarc/2));
			draw_vertex(x + xx, y + yy);
		}
			
	draw_primitive_end();
	*/
	
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
#endregion

#region spawn
	
	
#endregion

#region Crawling
	if(keyboard_check_released(vk_control)){
		max_speed_ = 3;
	}
	if(keyboard_check_pressed(vk_control)){
		max_speed_ = max_speed_/3;
	}
#endregion

#region Aim
#endregion