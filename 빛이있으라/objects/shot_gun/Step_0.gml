if(is_being_carried){
	var mouseb = mouse_check_button(mb_left);
	if(mouseb){
		if(remain_ammo > 0){
			if(weapon_check == true){
				instance_create_depth(x+lengthdir_x(length,direction), y+lengthdir_y(length,direction), -8, shot_gun_bullet);
				weapon_check = false;
				remain_ammo -= 1;
				alarm[0] = weapon_delay;
			}
		}
	}
}

if(is_being_carried){
	if(keyboard_check_pressed(ord("R"))){
		if(Player.total_ammo <= 0){
			return 0;
		}
		else if(remain_ammo == magazine){
			return 0;
		}
		else if(loading == true){
			return 0;
		}
		else{
			loading = true;
			Player.total_ammo += remain_ammo;
			remain_ammo = 0;
			Player.total_ammo -= magazine;
			weapon_check = false;
		
			alarm[1] = 240;
	
			weapon_check = true;
		}
	}
}