//기력
draw_sprite(sEnergybar_bg,0,energybar_x,energybar_y)	//기력 배경
draw_sprite_stretched(sEnergybar,0,x/8,energybar_x,(hp/player_hp_max) * energybar_width,energybar_height)
draw_sprite(sEnergybar_boarder,0,x/8,energybar_x)	//기력바 

//체력
var _playerHealth = hp/8
var _playerHealthMax = player_hp_max/8
var _playerHealthFrac = frac(_playerHealth)
_playerHealth -= _playerHealthFrac

for(var i = 1; i<= _playerHealthMax ; i++){
	draw_sprite(s_Health,
	(i> _playerHealth) + ((i == _playerHealth+1) && (_playerHealthFrac >0)),
	UI_MARGIN + ((i-1)* UI_HEALTHSEPARATION) + 350,
	UI_MARGIN)
}

if (restart)
{
	draw_text_color(640, 320,  "         Game over!\nPress Space to restart", c_yellow, c_yellow, c_yellow, c_yellow, 1); //Draw a text in the center of the GUI.
}