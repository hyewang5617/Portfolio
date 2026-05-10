room_speed = 60;
level = 0;

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
	
Enemy_num = knight_num[level] + archer_num[level] + tanker_num[level] + bomber_num[level];

randomize();

// Create the surface for the shadows
shadow_surface_ = noone;

// Get the tile layer map id
var _wall_map_id = layer_tilemap_get_id("WallTiles");

// Set up the grid
width_ = room_width div CELL_WIDTH;
height_ = room_height div CELL_HEIGHT;
grid_ = ds_grid_create(width_, height_);
ds_grid_set_region(grid_, 0, 0, width_ - 1, height_ - 1, VOID);

// Create the controller
var _controller_x = width_ div 2;
var _controller_y = height_ div 2;
var _controller_direction = irandom(3);
var _steps = 700;

 _player_start_x = _controller_x * CELL_WIDTH + CELL_WIDTH/2;
 _player_start_y = _controller_y * CELL_HEIGHT + CELL_HEIGHT/2;
instance_create_layer(_player_start_x, _player_start_y, "Instances", Player);

instance_create_layer(_player_start_x - 20, _player_start_y, "Instances", sling_shot);

// Choose the direction change odds
var _direction_change_odds = 1;

// Generate the level
repeat (_steps) {
	grid_[# _controller_x, _controller_y] = FLOOR;
	
	// Rnadomize the direction
	if (irandom(_direction_change_odds) == _direction_change_odds) {
		_controller_direction = irandom(3);	
	}
	
	// Move the controller
	var _x_direction = lengthdir_x(1, _controller_direction * 90);
	var _y_direction = lengthdir_y(1, _controller_direction * 90);
	_controller_x += _x_direction;
	_controller_y += _y_direction;
	
	// Make sure we don't move outside the room
	if (_controller_x < 2 || _controller_x >= width_ - 2) {
		_controller_x += -_x_direction * 2;
	}
	if (_controller_y < 2 || _controller_y >= height_ - 2) {
		_controller_y += -_y_direction * 2;
	}
}

// Create the walls tiles
for (var _y = 1; _y < height_-1; _y++) {
	for (var _x = 1; _x < width_-1; _x++) {
		if (grid_[# _x, _y] != FLOOR) {
			var _north_tile = grid_[# _x, _y-1] == VOID;
			var _west_tile = grid_[# _x-1, _y] == VOID;
			var _east_tile = grid_[# _x+1, _y] == VOID;
			var _south_tile = grid_[# _x, _y+1] == VOID;
		
			var _tile_index = NORTH*_north_tile + WEST*_west_tile + EAST*_east_tile + SOUTH*_south_tile + 1;
			if (_tile_index == 1) {
				grid_[# _x, _y] = FLOOR	
			}
		}
	}
}

// Create the walls tiles
for (var _y = 1; _y < height_-1; _y++) {
	for (var _x = 1; _x < width_-1; _x++) {
		if (grid_[# _x, _y] != FLOOR) {
			var _north_tile = grid_[# _x, _y-1] == VOID;
			var _west_tile = grid_[# _x-1, _y] == VOID;
			var _east_tile = grid_[# _x+1, _y] == VOID;
			var _south_tile = grid_[# _x, _y+1] == VOID;
		
			var _tile_index = NORTH*_north_tile + WEST*_west_tile + EAST*_east_tile + SOUTH*_south_tile + 1;
			tilemap_set(_wall_map_id, _tile_index, _x, _y);
			
			if(grid_[# _x, _y-1] == FLOOR || grid_[# _x-1, _y] == FLOOR || grid_[# _x+1, _y] == FLOOR || grid_[# _x, _y+1] == FLOOR || grid_[# _x+1, _y+1] == FLOOR || grid_[# _x+1, _y-1] == FLOOR || grid_[# _x-1, _y-1] == FLOOR || grid_[# _x-1, _y+1] == FLOOR){
				instance_create_depth(_x*64, _y*64, -5, wall);
			}
		}
	}
}

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
		instance_create_layer(enemy_x[location]*64,enemy_y[location]*64, "Enemy", oArcher);
	}

	for(var j = 0; j < tanker_num[level]; j++) {
		location = irandom(array_value);
		instance_create_layer(enemy_x[location]*64,enemy_y[location]*64, "Enemy", oTanker);
	}

	for(var j = 0; j < bomber_num[level]; j++) {
		location = irandom(array_value);
		instance_create_layer(enemy_x[location]*64,enemy_y[location]*64, "Enemy", oBomber);
	}