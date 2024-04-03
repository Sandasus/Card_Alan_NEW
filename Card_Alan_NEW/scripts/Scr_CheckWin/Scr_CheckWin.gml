// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function checkWin(playerChoice, enemyChoice) {
    if (playerChoice == enemyChoice) {
       
        return 0; // Return 0 for draw
		
    } else if ((playerChoice == CardType.Rock && enemyChoice == CardType.Scissors) ||
               (playerChoice == CardType.Scissors && enemyChoice == CardType.Paper) ||
               (playerChoice == CardType.Paper && enemyChoice == CardType.Rock)) {
     
	   
        return 1; // Return 1 for player win
		
    } else {
     
        return -1; // Return -1 for enemy win
    }
}