var elapsed_time ;
var character_image;
var mouse_image;

var timer;

function setup() {
  createCanvas(1520, 750);
  character_image = loadImage('shark.png')
  mouse_image = loadImage('fish.png')
  shark1 = new Shark(width/2,height/2,0.07,character_image)
  timer1 = new Timer(100)

}

function draw() {
  background(201,0,27);
  elapsed_time = millis() / 1000; 


  push()  //모래
  fill("#EEC55D")
  circle(width/2,height/2,
    map(sin(elapsed_time), -1,1,770,width));
  pop()

  push() //바다
  rectMode(CENTER)
  fill("#00E3C4")
  rect(width/2, height/2,400,400  )  //사각형중간 x좌표, 사각형중간 y좌표, 가로, 세로 
  pop()

  push()    //상어 나타내기 
  shark1.draw()
  pop()

  push()  //타이머 나타내기 
  timer1.draw()
  pop()

  image(mouse_image,mouseX,mouseY,58,40)    //마우스 물고기
  
}
