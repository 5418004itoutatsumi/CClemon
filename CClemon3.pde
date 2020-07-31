int ecount;
int pcount;
int diff;

class enemy{
  int command;
  int selectCommand(){
    if(diff==1){                 //easy
      if(ecount>=2){             //energy 2 ari
        int i=int(random(1,5));
        if(i==1){
          ecount++;
        }
        if(i==2){
          ecount--;
        }
        if(i==3){
          ecount-=2;
        }
        command=i;
      }else if(ecount==1){       //energy 2 nasi
        int i=int(random(1,4));
        if(i==1){
          ecount++;
        }else if(i==2){
          ecount--;
        }else{
          i++;                   //i = 4 ni
        }
        command=i;
      }else{                     //No energy  
        int i=int(random(1,3));
        if(i==1){
          ecount++;
        }else{
          i+=2;
        }
        command=i;
      }
    }else if(diff==2){            //nomal
      if(pcount==0){              //player No energy
        if(ecount>=1){
          int i=int(random(1,3));
          if(i==1){
            ecount++;
          }else{
            ecount--;
          }
          command=i;
        }else{
          ecount++;
          command=1;
        }
      }else{                       //player enargy 1 ijyou
        if(ecount==1){             //enemy energy 1
          int i=int(random(1,4));
          if(i==1){
            ecount++;
          }else if(i==2){
            ecount--;
          }else{
            i++;
          }
          command=i;
        }else if(ecount>=2){       //enemy energy 2 ijyoou
          int i=int(random(2,5));
          if(i==2){
            ecount--;
          }else if(i==3){
            ecount-=2;
          }
          command=i;
        }else{                      //enemy No energy
          int i=int(random(1,3));
          if(i==1){
            ecount++;
          }else{
            i+=2;
          }
          command=i;
        }
      }    
    }else{                        //hard  
      if(pcount==0){              //player No energy
        if(ecount>=1){
          int i=int(random(1,4));
          if(i==1){
            ecount++;
            command=i;
          }else{
            ecount--;
            command=2;
          }
        }else{
          ecount++;
          command=1;
        }
      }else{                       //player enargy 1 ijyou
        if(ecount==1){             //enemy energy 1
          int i=int(random(1,4));
          if(i==1){
            ecount++;
          }else if(i==2){
            ecount--;
          }else{
            i++;
          }
          command=i;
        }else if(ecount>=2){       //enemy energy 2 ijyoou
          int i=int(random(2,5));
          if(i==2){
            ecount--;
          }else if(i==3){
            ecount-=2;
          }
          command=i;
        }else{                      //enemy No energy
          int i=int(random(1,3));
          if(i==1){
            ecount++;
          }else{
            i+=2;
          }
          command=i;
        }
      }
    }
    return command;
  }
}

enemy e;

void setup() {
  size(800, 600);
  e=new enemy();
  noLoop();
}

void draw() {
  ecount=int(random(3));
  pcount=1;
  diff=3;
  println(ecount);
  println(pcount);
  int ecommand=e.selectCommand();
  println(ecommand); 
  println(ecount);
}
//1tame 2kougeki 3kyoukoigeki 4bougyo
