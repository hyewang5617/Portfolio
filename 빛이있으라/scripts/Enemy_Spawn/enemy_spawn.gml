// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Enemy_Spawn(argument0){
#region knight
knight_num[0] = 5;
knight_num[1] = 8;
knight_num[2] = 3;
knight_num[3] = 5;
knight_num[4] = 3;
knight_num[5] = 2;
knight_num[6] = 4;
knight_num[7] = 7;
knight_num[8] = 10;
knight_num[9] = 14;
#endregion

#region archer
archer_num[0] = 0;
archer_num[1] = 0;
archer_num[2] = 2;
archer_num[3] = 4;
archer_num[4] = 0;
archer_num[5] = 2;
archer_num[6] = 3;
archer_num[7] = 6;
archer_num[8] = 8;
archer_num[9] = 10;
#endregion

#region tanker
tanker_num[0] = 0;
tanker_num[1] = 0;
tanker_num[2] = 0;
tanker_num[3] = 0;
tanker_num[4] = 3;
tanker_num[5] = 3;
tanker_num[6] = 2;
tanker_num[7] = 3;
tanker_num[8] = 5;
tanker_num[9] = 7;
#endregion

#region bomber
bomber_num[0] = 0;
bomber_num[1] = 0;
bomber_num[2] = 0;
bomber_num[3] = 0;
bomber_num[4] = 0;
bomber_num[5] = 0;
bomber_num[6] = 1;
bomber_num[7] = 2;
bomber_num[8] = 4;
bomber_num[9] = 10;
#endregion

	width_ = room_width div CELL_WIDTH;
	height_ = room_height div CELL_HEIGHT;
	
	var level = argument0;
	
	level = 0;

	enemy_x = array_create(1, noone);
	enemy_y = array_create(1, noone);

	randomize();
	
	i = 0;

	for (var _y = 1; _y < height_-1; _y++) {
		for (var _x = 1; _x < width_-1; _x++) { 
			if (grid_[# _x, _y] == FLOOR && grid_[# _x, _y-1] == FLOOR && grid_[# _x-1, _y] == FLOOR && grid_[# _x+1, _y] == FLOOR && grid_[# _x, _y+1] == FLOOR) {
				enemy_x[i] = _x;
				enemy_y[i] = _y;
				array_resize(enemy_x, i+2);
				array_resize(enemy_y, i+2);
				i += 1;
			}
		}
	}
	array_value = i;

	for(var j = 0; j < knight_num[level]; j++) {
		location = irandom(array_value);
		instance_create_layer(enemy_x[location]*64,enemy_y[location]*64, "Enemy", oKnight);
	}

	for(var j = 0; j < archer_num[level]; j++) {
		location = irandom(array_value);
		instance_create_layer(enemy_x[location]*64,enemy_y[location]*64, "Enemy", oKnight);
	}

	for(var j = 0; j < tanker_num[level]; j++) {
		location = irandom(array_value);
		instance_create_layer(enemy_x[location]*64,enemy_y[location]*64, "Enemy", oKnight);
	}

	for(var j = 0; j < bomber_num[level]; j++) {
		location = irandom(array_value);
		instance_create_layer(enemy_x[location]*64,enemy_y[location]*64, "Enemy", oKnight);
	}

}