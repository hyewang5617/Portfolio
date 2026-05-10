int savedTime ;//시간저장
int passTime =1; //각 스테이지의 제한시간 저장 ex) 20초,30초
int stage_time =0; //각 스테이지의 시간 재는 타이머



//캐릭터
int g_chara_x; //캐릭터의 x좌표
int g_chara_y; //캐릭터의 y좌표
int g_chara_s = 1; //0=걍 서있기 /1 = 왼쪽 /2=오른쪽 
boolean g_isRight = false;  //캐릭터가 오른쪽을 바라볼때
boolean g_isLeft = false;  //캐릭터가 왼쪽을 바라볼때
int cnt = 0;//캐릭터 걷는 이미지 부르기 카운팅

//과일들의 클래스 Ball[] 선언
//클래스 Ball에 대한 정의,설명은 맨 밑에 있습니다
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
boolean nextstage = false;  //다음 스테이지 넘어가기 위한 참/거짓 변수
boolean Gameend = false;  //게임이 끝났는지 확인하는 참/거짓 변수
int stagenum = 0;   //몇 스테이지 기록하는 변수

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
  
  //게임 시작할때의 게임시간을 저장함
  savedTime= millis(); 
   
  textSize(50);//타이머 텍스트 사이즈
  fill(255);  //타이머 텍스트 색깔
   
}

void draw(){
  
  if(!Gameend){ //게임이 종료되지 않을때만 게임이 실행하게 함
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
   
    if(stagenum == 1 && stage_time >= passTime){ //스테이지 1이고 게임이 시작된후 시간제한이 지났을때 아래에 있는 코드 동작
        
        image(next_st,width/2,height/2);
        nextstage = true;  //다음 스테이지로 넘어가도 된다는 변수
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
    if(stagenum == 1){    //스테이지 1일때 사과가 나오게 하는 if문
       
      for (Ball ball : apples) {
      ball.display();
      ball.move();
    }
    }
    if(stagenum == 2){  //스테이지가 2일때 바나나가 나오게 하는 if문
     
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
   if(cnt >4){  //걷는 애니메이션을 위해 cnt라는 변수로 키보드를 몇번 눌렀는지 체크해서 일정 cnt이상일 시 다른 스프라이트로 바꾸기
     image( char_run_l1, g_chara_x, g_chara_y ); 
     if(cnt > 10){     //일정 cnt가 넘으면 다시 cnt를 0으로 초기화해서 계속 반복하게 함
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
    if ( ( g_chara_x -80 ) >= 0 ){   //게임 창 안에서만 왼쪽으로 갈 수 있게 하는 if문
        g_chara_x -=10;
    }
    cnt++;  //걸을때마다 cnt변수를 1씩 증가하게 해서 몇번 걸었는지 체크하고 그걸 통해 이미지 변형

        
  }
  
  if ( g_isRight ) {
    if ( ( g_chara_x + 80 ) <= width){  // 게임 창 안에서만 오른쪽으로 갈 수 있께 하는 if문

        g_chara_x +=10;
     }
    cnt++;
    
    
  }
}
}
  else{ //게임 오버일 시
   stage_time = millis() - savedTime;  
  image(gameover,width/2,height/2); // 게임오버 화면 띄우기
  if(stage_time >= 2000){//2초가 지나면
    image(retry,width/2,height/2);//다시 도전 화면 띄우기
  }
  
  
  }
}


void keyPressed() {  //키보드 누름
  if ( keyCode == RIGHT )  //키보드 오른쪽 화살표를 눌렀을때
  { 
    g_isRight = true;
    g_chara_s = 2;    //오른쪽 이미지
    
  }
  if ( keyCode == LEFT ) //키보드 왼쪽 화살표를 눌렀을때
  { 
    g_isLeft = true;
    g_chara_s = 1;  //왼쪽 이미지
  }
}

void keyReleased() //키보드 뗌
{
  if ( keyCode == RIGHT )   //오른쪽 화살표를 눌렀을때
  { 
    cnt =0;  //cnt변수를 다시 0으로 초기화해 서있는 모션 & 다시 왼쪽/오른쪽 화살표 눌렀을때 다시 걷는모션 처음부터

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
    savedTime= millis();// 스테이지 다시 시작시 스테이지 시작하는 초를 다시 기록해서 0초부터 다시 세게

    g_chara_x = width/2;  //캐릭터 위치 중앙으로 다시 초기화
    g_chara_y = height-100;
    stagenum ++; //스테이지 숫자 넘어가게  ex) 스테이지 1 -> 스테이지 2

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
     stagenum = 0;  //시작화면으로
     Gameend = false;
    
  }
  
}

//게임 시작할때 과일의 좌표와 캐릭터의 좌표, 게임 시작 시 시간 저장하기 위한 함수 = 게임을 준비하기 위한 변수들 초기화 함수
void GameReady(){
  
  savedTime= millis();  //처음시작할때 시간저장
  //캐릭터 위치 초기화
  g_chara_x = width/2;
  g_chara_y = height-100;
  
 
 //각 과일들이 클래스 Ball을 몇개 가질것인지 선언 / 여기서 각 Ball[]의 대괄호 안에 있는 숫자만 바꾸시면 게임에 나오는 과일 개수가 변합니다
  apples = new Ball[3];
  bananas = new Ball[5];
  grapes = new Ball[6];
  straws = new Ball[7];
  waters = new Ball[10];
  
  //각 과일들의 클래스 Ball에 값을 넣어 초기화
  for (int i = 0; i < apples.length; i++) { //반복문 for문을 사용해서 과일의 개수까지 반복 
    apples[i] = new Ball((width /apples.length)*(i+1)-50,10,random(0,10),random(0,2) );
  }                                                 // random() <-랜덤함수는 게임을 시작할때 사과가 떨어질 x축 방향과 y축 속도를 랜덤으로 정하기 위해 설정함    
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

//클래스 Ball / 과일들은 동일한 매커니즘을 지닌채 서로 다른 좌표값을 가져야 하므로 클래스 를 이용해서 서로같은 기능을 가진 서로다른 객체를 지니게함
class Ball {
  float x, y, dx, dy,xi,yi;//차례대로 x좌표, y좌표, x가속도(방향), y가속도(방향), x랜덤함수 변수, y랜덤함수 변수

  Ball(float x, float y,float xi,float yi) {
    this.x = x;
    this.y = y;
    this.dx = -5 +xi;//위에서 받아온 랜덤함수의 숫자로 x축의 가속도(방향)을 랜덤하게 받음
    this.dy = -1 -yi;  //위에서 받아온 랜덤함수의 숫자로 y축의 가속도(방향)을 랜덤하게 받음

  }

  void move() {
    if(y > height-50){  //땅에 닿을 시 
    Gameend = true;   //게임 종료
    }
  else{
     x += dx;  //x축 이동
    y += dy;  //y축이동
    
    //공이 벽에 닿았을때 튕기기
  if(x<10 || x > width - 15  ){
    dx *= -1;
  }
  if(y<10 || y > height - 15  ){
    dy *= -1;
  }
  //캐릭터에 닿을시
  if((x+10 > g_chara_x - 80-65 && x-10 < g_chara_x + 80) && y-10 > g_chara_y - 100){
    
    dy = -abs(dy); //y축 방향 위쪽으로
  }
  }
    
    }
    void display() {
      if(stagenum == 1){   //공 이미지 스테이지마다 달라지기
          image(apple,x,y); // 공그리기
        
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
