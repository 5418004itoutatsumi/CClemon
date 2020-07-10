class JudgeWin{
  int playerHP = 3;
  int enemyHP;
  JudgeWin(int diff){
    enemyHP = (diff - 1) * 2 + 1;
  }    
  void showAction(int playerCommand, int enemyCommand){
    String player, enemy;
    player = setString(playerCommand);
    enemy = setString(enemyCommand);
    text(player, width / 2 - 50, height / 2 - 100);
    text(enemy, width / 2 - 50, height / 2 + 100);
  }
  
  int judgecommandWin(int playerCommand, int enemyCommand){
    int result = 0;
    if(playerCommand <= 3 && enemyCommand < playerCommand){
      result = 1;
    }else if(enemyCommand <= 3 && playerCommand < enemyCommand){
      result = -1;
    }
    return result;
  }
  void HP(int flag){
    if(flag == 1){
      enemyHP -= 1;
    }else if(flag == -1){
      playerHP -= 1;
    }
    if(playerHP == 0){
      showResult(-1);
    }else if(enemyHP == 0){
      showResult(1);
    }
  }
  void showResult(int flag){
    if(flag == 1){
      text("You Win!", width / 2., height / 2);
    }else{
      text("You Lose", width / 2, height / 2);
    }
  }
}

String setString(int command){
  String result;
  if(command == 1){
    result = "溜める"; //Charge
  }else if(command == 2){
    result = "弱攻撃"; //Weak Attack
  }else if(command == 3){
    result = "強攻撃"; //Heavy Attack
  }else{
    result = "防御"; //Guard
  }
  return result;
}
    
