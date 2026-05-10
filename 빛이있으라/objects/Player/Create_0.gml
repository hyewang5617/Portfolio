 #region Player Stat
	x_speed_ = 0;
	y_speed_ = 0;
	max_speed_ = 3;
	acceleration_ = 0.5;
	hp = 38;
	total_ammo = 20;
	level = 0;
	
	restart = false;
#endregion

#region  hp_UI
player_hp_max = hp;

energybar_width = 100;
energybar_height = 12;
energybar_x = (2048/2) - (energybar_width/2);
energybar_y = ystart -100;

flash = 0;
#endregion

#region Key Set
	key_up = ord("W");
	key_left = ord("A");
	key_down = ord("S");
	key_right = ord("D");
	key_pickup = ord("E");
	
#endregion


weapon = noone;
pickup_radius = 50;


#region Aim
	instance_create_depth(x, y, 19, Aim)
#endregion

#region Camera
	instance_create_layer(x, y, "Instances", camera);
#endregion

#region FoV Set
	forsurface = surface_create(room_width, room_height);
	shadowsize = 1100
	fovarc = 120
#endregion