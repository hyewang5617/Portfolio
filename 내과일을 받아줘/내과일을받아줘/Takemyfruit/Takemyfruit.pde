int savedTime ;
int passTime =1; 
int stage_time =0;



//캐릭터
int g_chara_x; 
int g_chara_y; 
int g_chara_s = 1; //0=걍 서있기 /1 = 왼쪽 /2=오른쪽 
boolean g_isRight = false;  
boolean g_isLeft = false;  
int cnt = 0;


Ball[] apples;
Ball[] bananas;
Ball[] grapes;
Ball[] straws;
Ball[] waters;




//이미지
PImage back;
PImage gameover;
PImage start;
PImage retry;
PImage char_idle_l;
PImage char_idle_r;
PImage char_run_l1;
PImage char_run_l2;
PImage char_run_r1;
PImage char_run_r2;
PImage success;
PImage apple;
PImage grape;
PImage banana;
PImage straw;
PImage water;
PImage next_st;

//게임 변수
boolean nextstage = false; 
boolean Gameend = false;  
int stagenum = 0;  

void setup(){
  size(1440,800);
  back = loadImage("배경.jpeg");
  gameover = loadImage("실패.jpeg");
  success = loadImage("성공화면.jpeg");
  next_st = loadImage("다음 스테이지.jpeg");
  start = loadImage("시작화면.jpeg");
  retry = loadImage("다시도전.png");
  char_idle_l = loadImage( "왼쪽_idle.png" );
  char_idle_r = loadImage( "오른쪽_idle.png" );
  char_run_l1 = loadImage( "왼쪽_뛰기1.png" );
  char_run_l2 = loadImage( "왼쪽_뛰기2.png" );
  char_run_r1 = loadImage( "오른쪽_뛰기1.png" );
  char_run_r2 = loadImage( "오른쪽_뛰기2.png" );
  apple = loadImage( "사과.png" );
  grape = loadImage( "포도.png" );
  banana = loadImage( "바나나.png" );
  straw = loadImage( "딸기.png" );
  water = loadImage( "수박.png" );
  
  
  char_idle_l.resize(300,262);
  char_run_l1.resize(300,262);
  char_run_l2.resize(300,262);
  char_idle_r.resize(300,262);
  char_run_r1.resize(300,262);
  char_run_r2.resize(300,262);
  apple.resize(80,65);
  grape.resize(100,85);
  straw.resize(100,85);
  banana.resize(100,85);
  water.resize(100,85);
  back.resize(1440,800);
  gameover.resize(1440,800);
  success.resize(1440,800);
  next_st.resize(1440,800);
  start.resize(1440,800);
  retry.resize(1440,800);
  imageMode(CENTER);
  
   savedTime= millis(); 
   
  textSize(50);
  fill(255);  
   
}

void draw(){
  
  if(!Gameend){ 
  image(back,width/2,height/2);
    if(stagenum == 1){    
      stage_time = millis() - savedTime; 
      passTime = 15000;
    }
    if(stagenum == 2){    
      stage_time = millis() - savedTime; 
      passTime = 20000;
    }
    if(stagenum == 3){    
      stage_time = millis() - savedTime; 
      passTime = 25000;
    }
    if(stagenum == 4){    
      stage_time = millis() - savedTime; 
      passTime = 30000;
    }
    if(stagenum == 5){    
      stage_time = millis() - savedTime; 
      passTime = 35000;
    }
   
    if(stagenum == 1 && stage_time >= passTime){ 
        
        image(next_st,width/2,height/2);
        nextstage = true;  
      }
    else if( stagenum == 2 && stage_time >= passTime){
        image(next_st,width/2,height/2);
        nextstage = true;
      }
    else if( stagenum == 3 && stage_time >=passTime){
        image(next_st,width/2,height/2);
        nextstage = true;
      }
     else if( stagenum == 4 && stage_time >= passTime){
        image(next_st,width/2,height/2);
        nextstage = true;
      }
    else if( stagenum == 5 && stage_time >= passTime){
        image(success,width/2,height/2);
      }
    else if( stagenum == 0){
        image(start,width/2,height/2);
        nextstage = true;
      }
      
      
    else{
    if(stagenum == 1){    
       
      for (Ball ball : apples) {
      ball.display();
      ball.move();
    }
    }
    if(stagenum == 2){  
     
      for (Ball ball : bananas) {
      ball.display();
      ball.move();
    }
    }
    if(stagenum == 3){
      
      for (Ball ball : grapes) {
      ball.display();
      ball.move();
    }
    }
    if(stagenum == 4){
      
      for (Ball ball : straws) {
      ball.display();
      ball.move();
    }
    }
    if(stagenum == 5){
        
      for (Ball ball : waters) {
      ball.display();
      ball.move();
    }
    }
    

  //캐릭터 이미지
  
  switch( g_chara_s ) {   
   case 1:
   if(cnt >4){  
     image( char_run_l1, g_chara_x, g_chara_y ); 
     if(cnt > 10){    
       cnt =0;
     }
   }
   else{
     image( char_idle_l, g_chara_x, g_chara_y ); 
     
   }
    
    break;

  case 2:
   if(cnt >4){
     image( char_run_r1, g_chara_x, g_chara_y ); 
     if(cnt > 10){
       cnt =0;
     }
   }
   else{
     image( char_idle_r, g_chara_x, g_chara_y ); 
     
   }
    
   break;
  }
  
  //타이머
  text((passTime - stage_time)/1000+1, width/2, 50);

  
  //캐릭터 이동
  if ( g_isLeft ) {
    if ( ( g_chara_x -80 ) >= 0 ){  
        g_chara_x -=10;
    }
    cnt++;  
        
  }
  
  if ( g_isRight ) {
    if ( ( g_chara_x + 80 ) <= width){  
        g_chara_x +=10;
     }
    cnt++;
    
    
  }
}
}
  else{
   stage_time = millis() - savedTime;  
  image(gameover,width/2,height/2);
  if(stage_time >= 2000){
    image(retry,width/2,height/2);
  }
  
  
  }
}


void keyPressed() { 
  if ( keyCode == RIGHT ) 
  { 
    g_isRight = true;
    g_chara_s = 2;    
    
  }
  if ( keyCode == LEFT ) 
  { 
    g_isLeft = true;
    g_chara_s = 1;  
  }
}

void keyReleased() 
{
  if ( keyCode == RIGHT )   
  { 
    cnt =0;  
    g_isRight = false;
  }  
  if ( keyCode == LEFT )
  { 
    cnt =0;
    g_isLeft = false;
  }
}

//마우스 클릭시
void mousePressed(){
  //다음 단계 오른쪽 화살표
  if(nextstage == true && (mouseX >= 1195 && mouseX <= 1380 && mouseY <= 785 && mouseY >= 680) ){ 
    
    nextstage = false;
    savedTime= millis();
    g_chara_x = width/2; 
    g_chara_y = height-100;
    stagenum ++; 
  }
  //다음단계 왼쪽 화살표
  if(nextstage == true && (mouseX >= 45 && mouseX <= 200 && mouseY <= 785 && mouseY >= 685) ){
    nextstage = false;
    savedTime= millis();
     GameReady();
  }
  if(stagenum == 0 && (mouseX >= 590 && mouseX <= 920 && mouseY <= 735 && mouseY >= 620)){  
    stagenum ++;
    nextstage = false;
    savedTime= millis();
    GameReady();
  }
  //다시 시도 오른쪽 화살표
  if(Gameend ==  true && (mouseX >= 1200 && mouseX <= 1380 && mouseY <= 785 && mouseY >= 675)){  
    GameReady();
    Gameend = false;
  }
  //다시 시도 완쪽 화살표
   if(Gameend ==  true && (mouseX >= 50 && mouseX <= 200 && mouseY <= 785 && mouseY >= 685)){  
     stagenum = 0;
     Gameend = false;
    
  }
  
}

void GameReady(){
  savedTime= millis();
  g_chara_x = width/2;
  g_chara_y = height-100;
  
 
 
  apples = new Ball[3];
  bananas = new Ball[5];
  grapes = new Ball[6];
  straws = new Ball[7];
  waters = new Ball[10];
  
  for (int i = 0; i < apples.length; i++) {  
    apples[i] = new Ball((width /apples.length)*(i+1)-50,10,random(0,10),random(0,2) );
  }                                                     
  for (int i = 0; i < bananas.length; i++) {
    bananas[i] = new Ball((width /bananas.length)*(i+1)-50,10,random(0,10),random(0,2) );
  }
  for (int i = 0; i < grapes.length; i++) {
    grapes[i] = new Ball((width /grapes.length)*(i+1)-50,10,random(0,10),random(0,2) );
  }
  for (int i = 0; i < straws.length; i++) {
    straws[i] = new Ball((width /straws.length)*(i+1)-50,10,random(0,10),random(0,2) );
  }
  for (int i = 0; i < waters.length; i++) {
    waters[i] = new Ball((width /waters.length)*(i+1)-50,10,random(0,10),random(0,2) );
  }
  
 

}

class Ball {
  float x, y, dx, dy,xi,yi;
  Ball(float x, float y,float xi,float yi) {
    this.x = x;
    this.y = y;
    this.dx = -5 +xi;
    this.dy = -1 -yi;  
  }

  void move() {
    if(y > height-50){  
    Gameend = true;  
    }
  else{
     x += dx; 
    y += dy;  
    
  if(x<10 || x > width - 15  ){
    dx *= -1;
  }
  if(y<10 || y > height - 15  ){
    dy *= -1;
  }

  if((x+10 > g_chara_x - 80-65 && x-10 < g_chara_x + 80) && y-10 > g_chara_y - 100){
    
    dy = -abs(dy); 
  }
  }
    
    }
    void display() {
      if(stagenum == 1){  
          image(apple,x,y); 
        
      }
      else if(stagenum == 2){
        image(grape,x,y);
        
      }
      else if(stagenum == 3){
        image(banana,x,y);
      }
      else if(stagenum == 4){
        image(straw,x,y);
      }
      else if(stagenum == 5){
        image(water,x,y);
      }
  }

  }
