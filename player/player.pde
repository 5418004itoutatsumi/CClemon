int playerCm=0;
class Player{
  int[] timeList={10,5,3};
  int countDown;
 
  int playerCommand(){
    if(keyPressed){
      return playerCm;
    }else{
      return 0;
    }
  }
  
  void count(int i){
    int timeLimit;
    timeLimit=timeList[i-1];
    background(240);
   
    int ms = millis()/1000;
 
    fill(0);
    countDown = timeLimit - ms;
    if(countDown > 0){
      text(""+countDown, 750, 40);
    } else {
      background(255, 0, 0);
      text("TIME OVER", 330, 250);
    }
  }
  }

void keyPressed() {
  if (key =='w') {         
    playerCm=1;
  }  else if (key == 's') {  
    playerCm=2;
  }else if (key == 'd') {  
    playerCm=3;
  }else if (key == 'a') {  
    playerCm=4;
  }
}
