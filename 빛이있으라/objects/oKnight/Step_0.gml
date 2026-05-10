if(speed == 0){
	sprite_index=s_knight_idle;
}

if(collision_circle(x, y, reaction_radius, Player, false, true)){
	direction=point_direction(x,y,Player.x,Player.y)
	
	if sign(Player.x - x)<0{
		image_xscale = -1; 
	}
	
	if sign(Player.x - x)>0{
		image_xscale = 1; 
	}
	
	if point_distance(x,y,Player.x,Player.y)<100
	{
		sprite_index=s_knight_attack;
		if(fight == true){
		speed=1;
		instance_create_depth(x, y, depth, o_knight_attack);
		fight = false;
		alarm[0] = 50;
	}
	}
	
	if point_distance(x,y,Player.x,Player.y)>100
	{
		sprite_index=s_knight_walk;
		speed=1.5;
	}
	
}else{
	speed = 0;
}

randomize();

item = irandom(3);

if(hp <= 0){
	instance_destroy(self);
	Enemy_Number();
	item_spawner(x,y,item);
}

if(!collision_line(x, y, Player.x, Player.y, wall, false, true)){
	inVisible = true;
} else {
	inVisible = false;
}


hspd = lengthdir_x(speed, direction);

vspd = lengthdir_y(speed, direction);
	
if (hspd > 0) {
		if (grid_meeting()) {
			x = bbox_right&~(CELL_WIDTH-1);
			x -= bbox_right-x;
			hspd = 0;
		}
} else if (hspd < 0) {
	// Left collisions
	if (grid_meeting()) {
		x = bbox_left&~(CELL_WIDTH-1);
		x += CELL_WIDTH+x-bbox_left;
		hspd = 0;
	}
}
	
// Move vertically
	
// Vertical collisions
if (vspd > 0) {
	// Bottom collisions
	if (grid_meeting()) {
		y = bbox_bottom&~(CELL_HEIGHT-1);
		y -= bbox_bottom-y;
		vspd = 0;
	}
} else if (vspd < 0) {
	// Top collisions
	if (grid_meeting()) {
		y = bbox_top&~(CELL_HEIGHT-1);
		y += CELL_HEIGHT+y-bbox_top;
		vspd = 0;
	}
}

