/// @description Insert description here
// You can write your code in this editor
if (!dealToPlayer) 
{
    // Dealing cards to the bot's deck
    if (dealIndex < 3)
	{ 
        var card = ds_list_find_value(all_card_list, 0);
        card.dest_x = 224 + (dealIndex * 150); 
        card.dest_y = 128; 
        card.moving = true; 
        ds_list_add(bot_card_list, card); // Add the card to the bot's hand list
        ds_list_delete(all_card_list, 0); // Remove the card from the main deck list

        dealIndex++; // Prepare to deal the next card
        alarm[0] = room_speed * 0.5; // Set the alarm to trigger again for the next card
    } 
	else 
	{
        // After 3 cards are dealt to the bot, prepare to deal to the player
        dealToPlayer = true;
        dealIndex = 0; // Reset index for dealing to the player
        alarm[0] = room_speed * 0.5; 
    }
} 
else 
{
    // Dealing cards to the player's hand
    if (dealIndex < 3) 
	{
        var card = ds_list_find_value(all_card_list, 0);
        card.dest_x = 224 + (dealIndex * 150); 
        card.dest_y = 646; 
        card.moving = true; 
		card.reveal = true;
        ds_list_add(my_card_list, card); // Add the card to the player's hand list
        ds_list_delete(all_card_list, 0); // Remove the card from the main deck list

        dealIndex++; // Prepare to deal the next card
        if (dealIndex < 3) 
		{
            alarm[0] = room_speed * 0.5; 
        } else if(currentState == GameState.DealCards)
		{
			//show_debug_message("Entering Eenmy turn")
            dealToPlayerDone = true;
        }
    }
}



