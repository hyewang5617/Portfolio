target=instance_nearest(x,y,Player);
dist=distance_to_object(target);
if 50>dist{
	Player.hp-=15;
	instance_destroy(self)
}
