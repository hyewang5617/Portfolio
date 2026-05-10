// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function item_spawner(argument0, argument1, argument2){
	var x_ = argument0
	var y_ = argument1
	var value = argument2
	
	if(value == 0){
		instance_create_depth(x_, y_, -7, extra_ammo);
	}
	if(value == 1){
		instance_create_depth(x_, y_, -7, extra_health);
	}
	if(value == 2){
		instance_create_depth(x_, y_, -7, crossbow);
	}
	if(value == 3){
		instance_create_depth(x_, y_, -7, revolver);
	}
	if(value == 4){
		instance_create_depth(x_, y_, -7, long_gun);
	}
	if(value == 5){
		instance_create_depth(x_, y_, -7, rapid_gun);
	}
	if(value == 6){
		instance_create_depth(x_, y_, -7, shot_gun);
	}
	if(value == 7){
		instance_create_depth(x_, y_, -7, sniper);
	}
	if(value == 8){
		instance_create_depth(x_, y_, -7, rpg);
	}
}