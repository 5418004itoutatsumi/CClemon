PImage exitImg, ruleImg;
boolean isStartMenu = true;
boolean buttonClicked = false;
boolean nextClicked = false;
class Start {
  int x, y, xLen, yLen;
  boolean modeClicked = false; //他のクラスで使えるかも
  String str;
  
  Start(String str1, int x1, int y1, int xLen1, int yLen1) {
    str = str1;
    x = x1;
    y = y1;
    xLen = xLen1;
    yLen = yLen1;
  }
  
  void textInRect() {
    strokeWeight(5);
    strokeJoin(BEVEL);
    fill(#ffc0cb);
    rect(x, y, xLen, yLen);
    textSize(yLen * (4.0/5.0));
    fill(0);
    text(str, x, y + (yLen/3.0));
  }
  
  void showRule() {
    if(isStartMenu == false) {
      exitImg = loadImage("exit.png");
      if(nextClicked == false) {
        background(#98fb98);
        strokeJoin(BEVEL);
        fill(255);
        rect(width/2, height/2, width*2/3, height*2/3);
        imageMode(CENTER);
        image(exitImg, width*4/5, height/5, 50, 50);
        rect(width/2, height - 50, 100, 40);
        textSize(20);
        fill(0);
        text("このゲームはプレイヤー対コンピュータで行う．基本行動には溜める(W)，ガード(A)，弱攻撃(S)，強攻撃(D)があり，プレイヤーとコンピュータは毎ターンコマンド選択をする．お互いが選んだコマンドにより勝敗が決まり，負けるとライフが1減る．先にライフが0になった方の負けとなる．相性表は次のページへGO", width/2, height/2, width/2, height/2);
        text("次に進む", width/2, height - 40);
        text("1/2", width - 40, height - 20);
      } else {
        background(#98fb98);
        fill(255);
        rect(width/2, height/2, width*2/3, height*2/3);
        imageMode(CENTER);
        ruleImg = loadImage("rule.png");
        image(ruleImg, width/2, height/2);
        image(exitImg, width*4/5, height/5, 50, 50);
        rect(width/2, height - 50, 100, 40);
        textSize(20);
        fill(0);
        text("前に戻る", width/2, height - 40);
        text("2/2", width - 40, height - 20);
      }
    } else {
      textInRect();
    }
    if(buttonClicked) {
      background(#98fb98);
      fill(0);
      text("ゲーム開始", width/2, height/2);
    }
  }
  
  void selectDif() {
    if(buttonClicked == false) {
      textInRect();
    }
  }
  
  boolean isInside() {
    if(mouseX >= x-xLen/2 && mouseX <= x+xLen/2 && mouseY >= y-yLen/2 && mouseY <= y+yLen/2) {
      return true;
    } else {
      return false;
    }
  }
}

Start rule, easy, hard, G, exit, next;

void setup() {
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  rectMode(CENTER);
  size(800, 600);
  background(#98fb98);
  rule = new Start("ルール説明", width/2, height*7/8, 400, 50);
  easy = new Start("下級", width/5, height/2, 200, 100); 
  hard = new Start("上級", width/2, height/2, 200, 100);
  G = new Start("G級", width*4/5, height/2, 200, 100);
  exit = new Start("X", width*4/5, height/5, 50, 50);
  next = new Start("next", width/2, height - 50, 100, 40);
}

void draw() {
  textAlign(CENTER);
  textSize(100);
  fill(#ffd700);
  text("CCレモン", width/2, height/3);
  easy.selectDif();
  hard.selectDif();
  G.selectDif();
  rule.showRule();
  if(easy.modeClicked) println(0);
  else if(hard.modeClicked) println(1);
  else if(G.modeClicked) println(2);
}

void mouseClicked() {
  if(next.isInside() && isStartMenu == false) {
    if(nextClicked == false) {
      nextClicked = true;
    } else {
      nextClicked = false;
    }
  }
  
  if(rule.isInside()) {
    rule.modeClicked = true;
    isStartMenu = false;
  }
  
  if(rule.modeClicked == true && exit.isInside()) {
    background(#98fb98);
    rule.modeClicked = false;
    isStartMenu = true;
  }

  if(easy.isInside()) {
    buttonClicked = true;
    easy.modeClicked = true;
  }
  if(hard.isInside()) {
    buttonClicked = true;
    hard.modeClicked = true;
  }
  if(G.isInside()) {
    buttonClicked = true;
    G.modeClicked = true;
  }
}
