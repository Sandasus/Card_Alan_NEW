spawn_timer = 0;

spawn = true;

spawn_timer_max = .1*room_speed;

card_num =0;

enum GameState {
    Initialize,
    DealCards,
    PlayerTurn,
    EnemyTurn,
    CheckWin,
    EndGame,
	Reshuffle,
}

State_Now = GameState.Initialize;

switch_state_timer = .5*room_speed;

round_num = 1;

all_card_list = ds_list_create();

bot_card_list = ds_list_create();

my_card_list = ds_list_create();

discard_card_list = ds_list_create();

dealIndex = 0;

dealToPlayer = false;

dealToPlayerDone = false;

deal_wait = false;

Enemy_Choose_Card = 0;

Player_Selected_Card =0;

Enter_Enemy_Timer = .5*room_speed;

globalvar Player_Score;
Player_Score = 0;

globalvar Enemy_Score;
Enemy_Score = 0;

add = false;
waiting = false;

discard_wait = false;

discard_player_chosen = false;

discard_enemy_chosen = false;

discard_enemy_chosen_deck = false;

discard_player_chosen_deck = false;
discard_switch = false;
discard_deltay = 0;

shuffle = false;
discard_waiting = false