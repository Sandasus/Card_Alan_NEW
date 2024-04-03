/// @description Insert description here
// You can write your code in this editor
randomize();
if(deal_wait){
	return;
}
if(discard_wait){
	return;
}

switch(State_Now){
	
	case GameState.Initialize:
		for (var i = 0; i < 8; i++){
			
			addCardToDeck(CardType.Rock);
			
			addCardToDeck(CardType.Paper);
			
			addCardToDeck(CardType.Scissors);
			
			card_num += 1;
		}
		for (var i = ds_list_size(all_card_list) - 1; i > 0; i--){
			
			var j = irandom(i);
			
			var temp = all_card_list[| i];
			
			all_card_list[| i] = all_card_list[| j];
			
			all_card_list[| j] = temp;
		}
		
		for (var i = 0; i < 24; i++){
			
			var card = ds_list_find_value(all_card_list,i);
			
			card.moving = true;
			
			card.dest_x = 96; 
			
		    card.dest_y = 488+i*3;
			
			card.target_depth = i;
			
			card.xspd = 0.3;
			
			card.yspd = 0.3;
			
		}
		audio_play_sound(Sd_Shuffle,2,false);
	
		State_Now = GameState.DealCards;
		
        break;
		
	case GameState.DealCards:
		
		if (!dealToPlayer && dealIndex < 3) {
		
			var card = ds_list_find_value(all_card_list, 0);
			
			card.dest_x = 224 + (dealIndex * 150); 
			
			card.dest_y = 128; 
			
			card.moving = true;
			
			audio_play_sound(Sd_Dealing,2,false);
			
			ds_list_add(bot_card_list, card);
			
			ds_list_delete(all_card_list, 0);
			
			dealIndex++;
			
			alarm[1]= room_speed*0.5;
			
			deal_wait = true;
		} else if (dealIndex >= 3) {
					
			dealToPlayer = true;
			
			dealIndex = 0; // Reset for dealing to the player
			
		}if(dealToPlayer){
			
			   if (dealIndex < 3) {
				   
		        var card = ds_list_find_value(all_card_list, 0);
				
		        card.dest_x = 224 + (dealIndex * 150); 
				
		        card.dest_y = 646; 
				
		        card.moving = true; 
				
				card.reveal = true;
				
				audio_play_sound(Sd_Dealing,2,false);
				
		        ds_list_add(my_card_list, card); // Add the card to the player's hand list
		        ds_list_delete(all_card_list, 0); // Remove the card from the main deck list

		        dealIndex++; // Prepare to deal the next card;
				
				alarm[1]= room_speed*0.5;
				
				deal_wait = true;
				
				if(State_Now == GameState.DealCards){
				
					  dealToPlayerDone = true
				
				}
			}
		}
		
		if(dealIndex >=3 and dealToPlayerDone == true){
		
			Enter_Enemy_Timer--;
			
			State_Now = GameState.EnemyTurn;
			
		}
		break;
		
		
	case GameState.EnemyTurn:
		var enemy_choose= irandom(2);
		
		
		var card = ds_list_find_value(bot_card_list,enemy_choose);
		
		Enemy_Choose_Card = card;
		
		ds_list_delete(bot_card_list,enemy_choose);
		
		card.dest_x = 374;
		
		card.dest_y = 270;
		
		audio_play_sound(Sd_Dealing,2,false);
		
		selected = false;
		
		State_Now = GameState.PlayerTurn;
		
		break;
		
	case GameState.PlayerTurn:
		
		for(var _i =0; _i<3; _i++){
			
			var card = ds_list_find_value(my_card_list,_i)
			
			card.in_hand  = true;
			
			if(card.is_selected = true){
		
				audio_play_sound(Sd_Dealing,2,false);
				
				Player_Selected_Card = card;
				
				var player_select = ds_list_find_index(my_card_list,Player_Selected_Card);
			
				
			}
		}
		
		if(selected = true){
			
			card_num = 0;
			
			waiting = false;
			
			switch_state_timer=0.5*room_speed;
			
			State_Now = GameState.CheckWin;
			
		}
		break;
		
	case GameState.CheckWin:
		Enemy_Choose_Card.reveal = true;
		
		var playerChoice = Player_Selected_Card.CardType;
		
		var enemyChoice = Enemy_Choose_Card.CardType;
		
		var result = checkWin(playerChoice, enemyChoice);
		
		if(result == 1 and !add){
			
			Player_Score+=1;
			
			audio_play_sound(Sd_Winning,2,false);
			
			add = true;
			
			waiting = true;
		
		}
		
		if(result == -1 and !add){
			
			audio_play_sound(Sd_Losing,2,false);
			
			Enemy_Score+=1;
			
			waiting = true;
			
			add = true;
			
		}
		
		if(result ==0 and !add){
			
			add = true;
			
			waiting = true;
	
		}
		
		if(waiting = true){
			
			switch_state_timer--;
			
		}
		
		if(switch_state_timer<=0){
			
			add = false;
			
			waiting = false;
			
			switch_state_timer=.5*room_speed;
			
			discard_enemy_chosen = false;
			
			discard_wait = false;
			
			discard_player_chosen = false;
			
			discard_enemy_chosen = false;
			
			discard_enemy_chosen_deck = false;
			
			discard_player_chosen_deck = false;
			
			discard_switch = false;
			
			State_Now = GameState.EndGame;
		}
		
		break;
		
	case GameState.EndGame:
		var discard_pile_x = 672; 
		
		var discard_pile_y = 280-discard_deltay*3; 
		
		if(discard_enemy_chosen = false)
		{
			ds_list_add(discard_card_list,Enemy_Choose_Card);

			Enemy_Choose_Card.dest_x = discard_pile_x;
			
			Enemy_Choose_Card.dest_y = discard_pile_y;
			
			audio_play_sound(Sd_Dealing,2,false);
			
			alarm[2] = .5*room_speed;
			
			discard_wait = true;
			
			discard_enemy_chosen = true;

			discard_deltay+=1;
			
			var card_depth = ds_list_find_index(discard_card_list,Enemy_Choose_Card);
			
			Enemy_Choose_Card.target_depth = -card_depth;
			
		}
		
		if(discard_player_chosen = true){
			
			ds_list_add(discard_card_list,Player_Selected_Card);
			
			var discard_waiting = false;
			
			var player_select = ds_list_find_index(my_card_list,Player_Selected_Card);
			
			ds_list_delete(my_card_list,player_select);
			
			var card_depth = ds_list_find_index(discard_card_list,Player_Selected_Card);
			
			Player_Selected_Card.in_hand = false;
			
			Player_Selected_Card.moving = false;
			
			Player_Selected_Card.discarding = true;
			
			Player_Selected_Card.dest_discard_x = discard_pile_x;
			
		    Player_Selected_Card.dest_discard_y = discard_pile_y;
			
			Player_Selected_Card.target_depth = -card_depth;
			
			audio_play_sound(Sd_Dealing,2,false);
			
			alarm[3] = .5*room_speed;
			
			discard_wait = true;
			
			discard_deltay+=1;
			
			discard_player_chosen = false;
			
		}
		
		if(discard_enemy_chosen_deck = true and !discard_wait){
			
			if (ds_list_size(bot_card_list) > 0){
				
	            var card = ds_list_find_value(bot_card_list, ds_list_size(bot_card_list) - 1);
				
				card.reveal = true;
				
	            card.dest_x = discard_pile_x;
				
	            card.dest_y = discard_pile_y;
				
				audio_play_sound(Sd_Dealing,2,false);
				
	            ds_list_add(discard_card_list, card);
				
				var card_depth = ds_list_find_index(discard_card_list,card);
				
				card.target_depth = -card_depth;
				
	            ds_list_delete(bot_card_list, ds_list_size(bot_card_list) - 1);
				
				discard_deltay+=1;
				
	            alarm[3] = room_speed * 0.5; // Set alarm for the next card
				
	            discard_wait = true; 
				
			}
			
			if (ds_list_size(bot_card_list) =0){
				
				alarm[4] =room_speed * 0.5;
			}
		}
		
		if(discard_player_chosen_deck = true and !discard_wait){
			
			if (ds_list_size(my_card_list) > 0){
				
	            var card = ds_list_find_value(my_card_list, ds_list_size(my_card_list) - 1);
				
				card.reveal = true;
				
				card.in_hand = false;
				
	            card.dest_x = discard_pile_x;
				
	            card.dest_y = discard_pile_y;
				
				audio_play_sound(Sd_Dealing,2,false);
				
	            ds_list_add(discard_card_list, card);
				
				var card_depth = ds_list_find_index(discard_card_list,card);
				
				card.target_depth = -card_depth;
				
	            ds_list_delete(my_card_list, ds_list_size(my_card_list) - 1);
				
				discard_deltay+=1;
				
	            alarm[4] = room_speed * 0.5; // Set alarm for the next card
				
	            discard_wait = true; 
				
			}
			
			if (ds_list_size(my_card_list) =0){
				
				alarm[5] =room_speed * 0.5;
				
			}
		}
		
		if(discard_switch = true and ds_list_size(all_card_list) != 0){
			
			dealToPlayer = false;
			
			dealIndex = 0;
			
			discard_wait = false;
			
			dealToPlayerDone =false;
			
			State_Now = GameState.DealCards;
			
		}
		
		if(ds_list_size(discard_card_list) == 24){
			
			State_Now = GameState.Reshuffle;
			
		}
		
		break;
		
		case GameState.Reshuffle:
		
			var wait_timer = .1*room_speed
			
			var deal_waited = false
			
			if(ds_list_size(discard_card_list)!=0 and !deal_wait){
				
				var card = ds_list_find_value(discard_card_list, ds_list_size(discard_card_list)-1);
				
				card.discarding = false;
				
				card.moving = true;
				
			    card.dest_x = 96; 
				
			    card.dest_y = 550;
				
				card.xspd = 0.5;
				
				card.yspd = 0.5;
				
				audio_play_sound(Sd_Dealing,2,false);
				
			        // card.moving = false;
					
			    card.reveal = false; 
				
				card.is_selected = false;
				
			        // Add the card back to the main deck
			    ds_list_add(all_card_list,card);
	
			        // Remove the card from the discard pile
				var card_depth = ds_list_find_index(discard_card_list,card);
				
				card.target_depth = card_depth;
				
			    ds_list_delete(discard_card_list, ds_list_size(discard_card_list)-1);
				
				alarm[1]= room_speed*0.25;
				
				deal_wait = true;
				
				card_num +=1;
				
			}
			
			if(ds_list_size(discard_card_list) == 0){
				
				var listSize = ds_list_size(all_card_list);
				
				for (var i = 0; i < listSize / 2; i++){
					
				    // Calculate the index of the element to swap with
				    var swapIndex = listSize - 1 - i;
    
				    // Store the current element in a temporary variable
				    var temp = ds_list_find_value(all_card_list, i);
    
				    // Swap the current element with the corresponding element from the end
				    ds_list_set(all_card_list, i, ds_list_find_value(all_card_list, swapIndex));
					
				    ds_list_set(all_card_list, swapIndex, temp);
				}
				
				for (var i = 0; i < 24; i++){
			
					var card = ds_list_find_value(all_card_list,i);
					
					card.moving = true;
					
					card.dest_x = 96; 
					
				    card.dest_y = 488+i*3;
					
					card.target_depth = i;
					
					card.xspd = 0.5;
					
					card.yspd = 0.5;
					
					alarm[1]= room_speed*0.5;
					
					deal_wait = true
				}
				
				audio_play_sound(Sd_Shuffle,2,false);
				
				card_num = 0;
				
				dealToPlayer = false;
				
				dealIndex = 0;
				
				discard_wait = false;
				
				dealToPlayerDone =false;
				
				discard_deltay=0;
				
				switch_state_timer=0.5*room_speed;
				
				State_Now = GameState.DealCards;
				
				
			}
			break;
}
