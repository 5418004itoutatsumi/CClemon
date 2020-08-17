PImage exitImg, ruleImg;
boolean isStartMenu = true;
boolean modeClicked = false;
boolean nextClicked = false;
boolean gameOver = false;
boolean gameStart = false;
boolean isEX = false;
class Start {
  int wid, hei;

  Start(int w, int h) {
    wid = w;
    hei = h;
  }

  void textInRect(String str, int x, int y, int xLen, int yLen) {
    strokeWeight(5);
    strokeJoin(BEVEL);
    fill(#ffc0cb);
    rect(x, y, xLen, yLen);
    textSize(yLen * (4.0/5.0));
    fill(0);
    text(str, x, y + (yLen/3.0));
  }

  void showMenu() {
    background(#98fb98);
    text("CCレモン", wid/2, hei/3);
    textInRect("ルール説明", wid/2, hei*7/8, 400, 50);
    textInRect("下級", wid/5, hei/2, 200, 100);
    textInRect("上級", wid/2, hei/2, 200, 100);
    textInRect("G級", wid*4/5, hei/2, 200, 100);
    if (isEX) {
      textInRect("EX", wid / 2, hei/2 + 125, 200, 100);
    }
  }

  void showRule() {
    exitImg = loadImage("exit.png");
    if (nextClicked == false) {
      background(#98fb98);
      strokeJoin(BEVEL);
      fill(255);
      rect(wid/2, hei/2, wid*2/3, hei*2/3);
      imageMode(CENTER);
      image(exitImg, wid*4/5, hei/5, 50, 50);
      rect(wid/2, hei - 50, 100, 40);
      textSize(20);
      fill(0);
      text("このゲームはプレイヤー対コンピュータで行う．基本行動には溜める(W)，ガード(A)，弱攻撃(S)，強攻撃(D)があり，プレイヤーとコンピュータは毎ターンコマンド選択をする．弱攻撃はエネルギーを1，強攻撃はエネルギーを2消費する．お互いが選んだコマンドにより勝敗が決まり，負けるとライフが1減る．先にライフが0になった方の負けとなる．相性表は次のページへGO", width/2, height/2, width/2, height/2);
      text("次に進む", wid/2, hei - 40);
      text("1/2", wid - 40, hei - 20);
    } else {
      background(#98fb98);
      fill(255);
      rect(wid/2, hei/2, wid*2/3, hei*2/3);
      imageMode(CENTER);
      ruleImg = loadImage("rule.png");
      image(ruleImg, wid/2, hei/2);
      image(exitImg, wid*4/5, hei/5, 50, 50);
      rect(wid/2, hei - 50, 100, 40);
      textSize(20);
      fill(0);
      text("前に戻る", wid/2, hei - 40);
      text("2/2", wid - 40, hei - 20);
    }
  }

  int selectDif() {
    int d = 5;
    if (is_Inside(width/2, height*7/8, 400, 50)) {
      d = 0;  //Rule
    } else if (is_Inside(width/5, height/2, 200, 100)) {
      d = 1;  //easy
    } else if (is_Inside(width/2, height/2, 200, 100)) {
      d = 2;  //jo-kyu-
    } else if (is_Inside(width*4/5, height/2, 200, 100)) {
      d = 3;  //Gokiburi
    } else if (is_Inside(width/2, height/2 + 125, 200, 100) && isEX == true) {
      d = 4; //EX
    }
    return d;
  }

  boolean is_Inside(int x, int y, int xLen, int yLen) {
    if (mouseX >= x-xLen/2 && mouseX <= x+xLen/2 && mouseY >= y-yLen/2 && mouseY <= y+yLen/2) {
      return true;
    } else {
      return false;
    }
  }
}


void mouseClicked() {
  if (start.selectDif() == 0 && modeClicked == false) {
    isStartMenu = false;
  } 

  if ((start.selectDif() == 1 || start.selectDif() == 2 || start.selectDif() == 3 || (start.selectDif() == 4 && isEX == true)) && modeClicked == false) {
    background(#98fb98);
    text("スペースキーで開始", width / 2, height / 2);
    modeClicked = true;
    diff = start.selectDif();
    turn = 0;
  }

  if (gameOver == true) {
    playerHP = 3;
    modeClicked = false;
  }

  if (isStartMenu == false) {
    if (start.is_Inside(width*4/5, height/5, 50, 50) == true) {
      isStartMenu = true;
      imageMode(CORNER);
    }
    if (start.is_Inside(width/2, height- 50, 100, 40) == true) {
      if (nextClicked == false) {
        nextClicked = true;
      } else {
        nextClicked = false;
      }
    }
  }
  gameOver = false;
  gameStart = false;
}

class Enemy {
  int command;
  int diff;

  void setDiff(int dif) {
    diff = dif;
  }

  int selectCommand2(int diff) {
    int[][] commandTable = {{1, 1, 1, 2, 2, 2, 3, 3, 4, 4}, {1, 1, 2, 2, 2, 3, 3, 3, 4, 4}, {1, 1, 1, 2, 2, 2, 3, 3, 3, 3}};
    while (true) {
      int i = int(random(10));
      command = commandTable[diff - 1][i];
      //println(eCnt);
      if (command % 4 <= 1 || ( (command == 3 || command == 2) && eCnt >= command - 1)) {
        if (command == 1) {
          eCnt += 1;
        } else if (command == 2 || command == 3) {
          eCnt -= command - 1;
        }
        return command;
      }
    }
  }
}
int playerHP = 3;
int enemyHP;
class JudgeWin {

  void setHP(int diff) {
    enemyHP = (diff - 1) * 2 + 1;
  }

  void showAction(int playerCommand, int enemyCommand) {
    String player, enemy;
    player = setString(playerCommand);
    enemy = setString(enemyCommand);
    textSize(60);
    fill(255);
    rect(width / 2 - 100, height / 2 - 125, 200, 100);
    rect(width / 2 + 90, height / 2 + 185, 200, 100);
    fill(#ffd700);
    text(enemy, width / 2 - 100, height / 2 - 110);
    text(player, width / 2 + 90, height / 2 + 200);
  }

  int judgeCommandWin(int playerCommand, int enemyCommand) {
    int result = 0;
    if (playerCommand <= 3 && enemyCommand < playerCommand) {
      result = 1;
    } else if (enemyCommand <= 3 && playerCommand < enemyCommand) {
      result = -1;
    }
    return result;
  }
  void HP(int flag) {
    if (flag == 1) {
      enemyHP -= 1;
    } else if (flag == -1) {
      playerHP -= 1;
    }
    if (playerHP == 0) {
      showResult(-1);
    } else if (enemyHP == 0) {
      showResult(1);
    }
  }
  void showResult(int flag) {
    if (flag == 1) {
      background(#98fb98);
      text("You Win!", width / 2, height / 2);
      textSize(50);
      text("クリックでタイトルに戻る", width / 2, height / 2 + 100);
      if (diff == 3) {
        isEX = true;
        text("EXステージが出現！", width / 2, height / 2 + 150);
      }
      gameOver = true;
    } else {
      background(#98fb98);
      text("You Lose", width / 2, height / 2);
      textSize(50);
      text("クリックでタイトルに戻る", width / 2, height / 2 + 100);
      gameOver = true;
    }
  }
}

int playerCm = 0;
int energyCnt = 0;
class Player {
  int[] timeList={5, 5, 3};
  int countDown;

  int playerCommand(int i) {
    int command = i;
    if (keyPressed) {
      //println(energyCnt, playerCm);
      if ((i == 3 || i == 2) && (energyCnt < i - 1)) {
        command = -1;
      } else if (i == 1) {
        energyCnt += 1;
      } else if (i == 3 || i == 2) {
        energyCnt -= i - 1;
      }
      return command;
    }
    energyCnt += 1;
    return 1;
  }
}

int pCnt = 0, eCnt = 0;
int diff;
JudgeWin judge;
Start start;
Enemy enemy;
Player player;

void setup() {
  start = new Start(width, height);
  judge = new JudgeWin();
  enemy = new Enemy();
  player = new Player();

  PFont font = createFont("Meiryo", 50);
  textFont(font);
  rectMode(CENTER);
  size(800, 600);
  background(#98fb98);
}

int pCommand, eCommand;
String W, A, S, D;

void draw() {
  textAlign(CENTER);
  textSize(100);
  fill(#ffd700);
  int[] timeTable = {5, 5, 3, 3};
  if (modeClicked == false) {
    start.showMenu();
    if (isStartMenu == false) {
      start.showRule();
    }
  }


  if (modeClicked == true) {
    PImage HP = loadImage("heart.png");
    PImage ME = loadImage("me.png");
    PImage monster = loadImage("monster1.png");
    if (diff == 1) {
      monster = loadImage("monster1.png");
    } else if (diff == 2) {
      monster = loadImage("monster2.png");
    } else if (diff == 3) {
      monster = loadImage("monster3.png");
    } else if (diff == 4) {
      monster = loadImage("monster4.png");
    }
    if (gameStart) {
      println("Command:" + playerCm);
      if (turn == 0) {
        background(#98fb98);
        textSize(40);
        println("OK");
        text("W(溜め) or A(防御) を選択", width / 2, height / 2);
      } else {
        background(#98fb98);
        W = "溜める";
        A = "防御";
        S = "弱攻撃";
        D = "強攻撃";
        println("Turn " + turn);
        image(monster, width / 2 + 10, 50);
        image(ME, width / 2 - 200, height - 300);
        while ( true ) {
          if (keyPressed) {
            pCommand = player.playerCommand(playerCm);
            break;
          }
        }
        if (pCommand == -1) {
          pCommand = 4;
        } else if (pCommand == 0) {
          energyCnt += 1;
          pCommand = 1;
        }
        eCommand = enemy.selectCommand2(diff);
        println("Player: " + pCommand + "Enemy: " + eCommand);
        println("Energy: " + energyCnt);
        textSize(35);
        fill(0);
        text("エネルギー", 125, height - 180);
        text(energyCnt, 125, height - 150);
        if (energyCnt == 0) {
          S = "防御";
          D = "防御";
        } else if (energyCnt == 1) {
          D = "防御";
        }
        drawCommand();
        judge.showAction(pCommand, eCommand);
        judge.HP(judge.judgeCommandWin(pCommand, eCommand));
        println("自分:"+playerHP+" 敵:"+enemyHP);
        for (int i = 1; i <= enemyHP; i++) {
          image(HP, i * 50, 50);
        }
        for (int i = 1; i <= playerHP; i++) {
          image(HP, i * 50, height - 100);
        }
        playerCm = 0;
      }
      turn += 1;
    }
  }
  gameStart = false;
}


int turn = 0;
void keyPressed() {
  if (key =='w') {         
    playerCm = 1;
    gameStart = true;
  } else if (key == 's') {  
    playerCm = 2;
    gameStart = true;
  } else if (key == 'd') {  
    playerCm = 3;
    gameStart = true;
  } else if (key == 'a') {  
    playerCm = 4;
    gameStart = true;
  }
  if (modeClicked) {
    if (key == ' ') {
      judge.setHP(diff);
      enemy.setDiff(diff);
      gameStart = true;
    }
  }
}

void drawCommand() {
  fill(255);
  strokeWeight(2);
  rect(width * 3 / 4, height / 2, 50, 50);
  rect(width * 3 / 4 + 50, height / 2 + 50, 50, 50);
  rect(width * 3 / 4 + 50, height / 2 - 50, 50, 50);
  rect(width * 3 / 4 + 100, height / 2, 50, 50);
  fill(255, 0, 0);
  textSize(25);
  text("A", width * 3 / 4, height / 2 + 10);
  text(A, width * 3 / 4 - 50, height / 2 + 30, 30, 150);
  text("S", width * 3 / 4 + 50, height / 2 + 60);
  text(S, width * 3 / 4 + 50, height / 2 + 110);
  text("W", width * 3 / 4 + 50, height / 2 - 40);
  text(W, width * 3 / 4 + 50, height / 2 - 90);
  text("D", width * 3 / 4 + 100, height / 2 + 10);
  text(D, width * 3 / 4 + 150, height / 2 + 30, 30, 150);
}

String setString(int command) {
  String result;
  if (command == 1) {
    result = "溜める"; //Charge
  } else if (command == 2) {
    result = "弱攻撃"; //Weak Attack
  } else if (command == 3) {
    result = "強攻撃"; //Heavy Attack
  } else {
    result = "防御"; //Guard
  }
  return result;
}
