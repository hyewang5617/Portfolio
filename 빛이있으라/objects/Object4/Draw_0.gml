draw_set_color(c_black)
draw_set_alpha(1)
if step >= 2400
{
	draw_text(190, 250, "So, light is back in the world")
	draw_text(65, 280, "and you go back to your daily life with your back to light.")
}
if delay == 0
{
	delay = 3605
}
if delay == 5
{
	instance_destroy(self)
}

if((delay > 5)&&(delay <= 25)){
	draw_set_alpha(delay*0.04);
}
