JudgeWin judge;

void setup() {
  size(800, 600);
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  judge = new JudgeWin(2);
  noLoop();
}

void draw() {
  judge.showAction(2, 3);
  judge.HP(judge.judgeCommandWin(2, 3));
  println(judge.playerHP, judge.enemyHP);
  
}
