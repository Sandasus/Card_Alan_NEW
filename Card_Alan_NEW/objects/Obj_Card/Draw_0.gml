/// @description Insert description here
// You can write your code in this editor

switch (CardType) 
{
	case CardType.Default:
	
		draw_sprite(Spr_CardBack, 0, x, y);
		
		break;
		
	case CardType.Rock:
	
		if(reveal = true){

			draw_sprite(Spr_CardRock, 0, x, y);
			
		}else{
			
			draw_sprite(Spr_CardBack, 0, x, y);
			
		}
		
		break;
		
	case CardType.Paper:
	
		if(reveal = true){
		
			draw_sprite(Spr_CardPaper, 0, x, y);
			
		}else{
			
			draw_sprite(Spr_CardBack, 0, x, y);
			
		}
		
		break;
		
	case CardType.Scissors:
	
		if(reveal = true){
			
			draw_sprite(Spr_CardScissors, 0, x, y);
			
		}else{
			
			draw_sprite(Spr_CardBack, 0, x, y);
			
		}
		
		break;

}

depth = target_depth;





