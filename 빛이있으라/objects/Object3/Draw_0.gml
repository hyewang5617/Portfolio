draw_set_color(c_black)
draw_set_alpha(1)
if step >= 420
{
	draw_text(10, 250, "The world where deep-rooted darkness had eroded finally began to glow.")
	draw_text(90, 280, "The lost moonlight fills up, and the sun rises again.")
}
if delay == 0
{
	delay = 2105
}
if delay == 5
{
	instance_destroy(self)
}
if((delay > 5)&&(delay <= 25)){
	draw_set_alpha(delay*0.04);
}
