if colli == 0{
	if instance_exists(Player){//플레이어가 있을 때, 이벤트를 작동하도록 
	     target=instance_nearest(x,y,Player);
	     dist=distance_to_object(target);//플레이어와의 거리를 측정   
		if  (att_range>=dist){
			move_towards_point(target.x,target.y,pspeed);
			sprite_index=s_bomber_walk;
			speed=3;
		}
 	 } 
}

if(speed == 0){
	sprite_index=s_bomber_idle;
}

randomize();

item = irandom(9);

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