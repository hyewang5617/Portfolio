var headsize = 8;
var bodywid = 15;
var bodyhei = 22.5;
var legwid = 15;
var leghei = 22.5;
var gab = 100;
var health_barX = 300;
var health_barY = 20;
var dmg1 = 0;
var dmg2 = 0;
var windspeed = 0;
var color1 = '#F5F60C'
var color2 = '100'

function mousePressed(){
  
    mouse.fir_x = mouseX;
    mouse.fir_y = mouseY;
    mouse.sec_x = mouseX; //싹다 초기화
    mouse.sec_y = mouseY;
  }

function mouseDragged() {
    max = 500;
    var dis = dist(mouse.fir_x,mouse.fir_y,mouseX,mouseY) 
    //var dis = Math.sqrt((mouse.fir_x-mouseX)*(mouse.fir_x-mouseX) + (mouse.fir_y-mouseY)*(mouse.fir_y-mouseY)); //첫번째 클릭이랑 마우스 위치
    if(dis >= max){
      if(round(dis) == max ){
        mouse.sec_x = mouseX;
        mouse.sec_y = mouseY;
      }
      //console.log(mouse.sec_x);
        /*push();
        
        translate((mouse.fir_x + mouse.sec_x) / 2, (mouse.fir_y + mouse.sec_y) / 2);
        rotate(atan2(mouse.sec_y - mouse.fir_y, mouse.sec_x -mouse.fir_x));
        text(mouse.dis, 0, -5);
        console.log(mouse.fir_x)
        pop();*/
     }
    else{
        //console.log(mouse.sec_x);
        mouse.sec_x = mouseX;
        mouse.sec_y = mouseY;
        textSize(10)
        console.log(round(dis));
        text(round(dis), mouseX, mouseY);
      }
    
    
  }
function mouseReleased() {
    //var arrow_dis = Math.sqrt((mouse.fir_x-mouse.sec_x)*(mouse.fir_x-mouse.sec_x) + (mouse.fir_y-mouse.sec_y)*(mouse.fir_y-mouse.sec_y)); //첫번째 클릭이랑 마우스 위치
    var x_power = map(mouse.fir_x-mouse.sec_x,0,max,0,20)
    var y_power = map(mouse.fir_y- mouse.sec_y,0,max,0,20)
    

    if(arrow.length == 0 )
        arrow.push(new Arrow(turning?width - gab * 2: gab * 2,height-bodyhei*2,10,x_power,y_power,turning))


    mouse.fir_x = null;
    mouse.fir_y = null;
    mouse.sec_x = null;
    mouse.sec_y = null;
}
function preload()
{
    bow = loadImage('bow.webp')
    bow2 = loadImage('bow2.webp')
    back = loadImage('assets/background.png');
    snow1 = loadImage('snow1.png');
    snow2 = loadImage('snow2.png');
}

function setup()
{
    createCanvas(1350, 600);
    //플레이어1
    head1= new Head(gab + bodywid/2 - (headsize/2), height - bodyhei - leghei - headsize, headsize)
    body1 = new Body(gab, height - bodyhei , bodywid, bodyhei)
    leg1 = new Leg(gab, height - bodyhei - leghei, legwid, leghei)
    //플레이어2
    head2= new Head(width - gab + bodywid/2 - (headsize/2),height - bodyhei - leghei - headsize, headsize)
    body2 = new Body(width - gab, height - bodyhei , bodywid, bodyhei)
    leg2 = new Leg(width - gab, height - bodyhei - leghei, legwid, leghei)

    //arrow = new Arrow(width/2, height/2, 30, 0, -5)
    arrow = [];
    mouse = new Mouse;
}

var turning =0;
var randomwind = 0
  
function draw()
{
    background(100);
    image(back, 0, 0,width,height);
    
    head1.draw();
    body1.draw();
    leg1.draw();

    head2.draw();
    body2.draw();
    leg2.draw();

    image(snow1, gab + bodywid/2 - (headsize/2)-25,  height - bodyhei - leghei - headsize-10,60,65);
    image(snow2,width - gab + bodywid/2 - (headsize/2)-60, height - bodyhei - leghei - headsize-7,110,70);


    //플레이어1 순서
    fill(color1)
    rect(gab + bodywid/2 - (headsize/2)-5,height - bodyhei - leghei - headsize-100,20);
    noFill()


    //플레이어2 순서
    fill(color2)
    rect(width - gab + bodywid/2 - (headsize/2)-5,height - bodyhei - leghei - headsize-100,20);
    noFill()

    for(var i=arrow.length-1;i>=0;i--){
        
        arrow[i].wind = round(windspeed);
        arrow[i].physics();
        arrow[i].draw();
      }
      
      mouse.draw();
    
    //체력바
    fill('red');
    if(dmg1 < 300)
      rect(30, 30, health_barX - dmg1, health_barY);
    if(dmg2 < 300)
      rect(width - 330, 30, health_barX - dmg2, health_barY);
    noFill();

    //image(bow, 100, 530, 40, 50);
    //image(bow,width - 120, 530, 40, 50);
    

    //바람방향
    fill(255)
    rect(width/2 - 50, 30, 100, 100);
    noFill()
    fill('#000000');
    textSize(20)
    if(windspeed > 0 )
    {
        text("->->", width/2 -20, 70);
    }
    else if(windspeed < 0)
    {
        text("<-<-",width/2 -20, 70);
    }
    text(abs(floor(windspeed)) + "m/s", width/2 - 20, 100);
    noFill();
    
    //플레이어1 히트박스
    //console.log(arrow[arrow.length - 1])
  if(arrow.length){
    if(arrow[arrow.length - 1].point_x <= head1.x + headsize && arrow[arrow.length - 1].point_x >= head1.x &&
      arrow[arrow.length - 1].point_y >= head1.y && arrow[arrow.length - 1].point_y <= head1.y + headsize)
    {
      dmg1 += 150;
      fill(255);
      rect(30 + health_barX, 30, -dmg1, health_barY)
      noFill();
    }
    else if(arrow[arrow.length - 1].point_x <= body1.x + bodywid && arrow[arrow.length - 1].point_x >= body1.x &&
      arrow[arrow.length - 1].point_y >= body1.y && arrow[arrow.length - 1].point_y <= body1.y + bodyhei)
    {
      dmg1 += 60;
      fill(255);
      rect(30 + health_barX, 30, -dmg1, health_barY);
      noFill();
    }
    else if(arrow[arrow.length - 1].point_x < leg1.x + legwid && arrow[arrow.length - 1].point_x >=leg1.x &&
      arrow[arrow.length - 1].point_y > leg1.y && arrow[arrow.length - 1].point_y < leg1.y + leghei)
    {
      dmg1 += 30;
      fill(255);
      rect(30 + health_barX, 30, -dmg1, health_barY);
      noFill();
    }
    //플레이어2 히트박스
    if(arrow[arrow.length - 1].point_x <= head2.x + headsize && arrow[arrow.length - 1].point_x >= head2.x &&
      arrow[arrow.length - 1].point_y >= head2.y && arrow[arrow.length - 1].point_y <= head2.y + headsize)
    {
      dmg2 += 50;
      fill(255);
      rect(width -30, 30, -dmg2, health_barY);
      noFill();
    }
    else if(arrow[arrow.length - 1].point_x <= body2.x + bodywid && arrow[arrow.length - 1].point_x >= body2.x &&
      arrow[arrow.length - 1].point_y >= body2.y && arrow[arrow.length - 1].point_y <= body2.y + bodyhei)
    {
      dmg2 += 20;
      fill(255);
      rect(width - 30, 30, -dmg2, health_barY);
      noFill();
    }
    else if(arrow[arrow.length - 1].point_x < leg2.x + legwid && arrow[arrow.length - 1].point_x > leg2.x &&
      arrow[arrow.length - 1].point_y > leg2.y && arrow[arrow.length - 1].point_y < leg2.y + leghei)
    {
      dmg2 += 10;
      fill(255);
      rect(width - 30, 30, -dmg2, health_barY);
      noFill();
    }
    if(turning == 1)
      {
            
        if(arrow[arrow.length - 1].point_y >= height)
        {
            turning = 0;
            arrow.splice(0, 1);
            randomwind = random(-5, 5);
            windspeed = randomwind;
            color1 = '#F5F60C'
            color2 = '100'
           
        }
          
      }
      else
      {
          if(arrow[arrow.length - 1].point_y >= height)
          {
            turning = 1;
            arrow.splice(0, 1);
            randomwind = random(-5, 5);
            windspeed = randomwind;
            color2 = '#F5F60C'
            color1 = '100'
          }    
      }
  }
    //끝났을때
    if(dmg1 >= 300)
    {
        fill(0);
        textSize(100);
        text("player 2 WIN!", width / 2 - 300, height / 2);
        noFill();
        throw "asdf"

    }
    else if(dmg2 >= 300)
    {
        fill(0);
        textSize(100);
        text("player 1 WIN!", width / 2 - 300, height / 2);
        noFill();
        throw "asdf"
    }
}