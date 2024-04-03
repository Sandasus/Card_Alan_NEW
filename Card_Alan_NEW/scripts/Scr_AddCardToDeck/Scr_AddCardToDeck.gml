// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function addCardToDeck(card_type)
{
	var card = instance_create_depth(100, 550, 0, Obj_Card);
	card.CardType = card_type;
	ds_list_add(all_card_list, card);
}

function reverse_list(_list) {
    var temp, i, j;
	 j = ds_list_size(_list) - 1;
    for (i = 0; i < ds_list_size(_list) - 1; i++) 
	{
			show_debug_message("Reversing list now")
			temp = ds_list_find_value(_list, i);
			ds_list_set(_list, i, ds_list_find_value(_list, j));
			ds_list_set(_list, j, temp); 
			j--;

    }
}