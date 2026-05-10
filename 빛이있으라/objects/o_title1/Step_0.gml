if(Light_on == 0){
	if(flashAlpha > 0 ){
	flashAlpha -= 0.01
	}
	if(flashAlpha <= 0 ){
		Light_on = 1;
	}
}
if(Light_on == 1){
	if(flashAlpha < 1 ){
	flashAlpha += 0.01
	}
	if(flashAlpha >= 1 ){
		Light_on = 0;
	}
	
}


