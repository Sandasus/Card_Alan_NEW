


if (moving){

    x = lerp(x, dest_x, xspd); 
	
    y = lerp(y, dest_y, yspd);
	
}
if (shuffle){

    x = lerp(x, dest_x, 0.5); 
	
    y = lerp(y, dest_y, 0.5);

}
if (discarding){

    x = lerp(x, dest_discard_x, 0.5);
	
    y = lerp(y, dest_discard_y, 0.5);

}

var hover_offset = 50;

var hover_speed = 0.1;

var mouse_over = (mouse_x >= x-35 && mouse_x <= x + 35) && (mouse_y >= y-50 && mouse_y <= y + 50)


if(in_hand = true){

	if(mouse_over){
		
		 y = lerp(y, original_y - hover_offset, hover_speed)
		 
		 if(mouse_check_button_pressed(mb_left) && selected = false && is_selected = false){
			 dest_x = 374
			 dest_y = 400
			 selected = true
			 is_selected = true
		 }
		 
	}else{
		
		 y = lerp(y, original_y, hover_speed);
		 
	}
	
	

}
