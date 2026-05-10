draw_set_color(c_black)
draw_set_alpha(1)
draw_text(90, 280, "Evil fell, and the source of darkness was restrained.")
if delay == 0
{
	delay = 365
}
if delay == 5
{
	instance_destroy(self)
}
if((delay > 5)&&(delay <= 25)){
	draw_set_alpha(delay*0.04);
}
