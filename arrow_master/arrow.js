class Arrow {
  constructor(x,y,size,x_speed,y_speed,turning){
      this.point_x = x;
      this.point_y = y;
      this.size = size;
      this.y_speed = y_speed;
      this.x_speed = x_speed;
      this.wind;
      this.time=0;
      this.turning = turning;
      //console.log(x_speed);
  }

  physics(){
      this.y_speed = this.y_speed + 9.8*deltaTime/700
      this.x_speed = this.x_speed + this.wind*deltaTime/800
      
      if(this.point_y <= height){ //땅에 안닿였을때
        this.previous_point_y = this.point_y
        this.point_y += this.y_speed;
        
      }
      else{ //땅에 닿였을때
        this.point_y = height;
        this.x_speed /=1.5;
        
      }
      this.previous_point_x =this.point_x
      this.point_x += this.x_speed
  }

  draw(){
    push()
    fill(255)
    if(this.turning == 1){
      
      circle(this.point_x,this.point_y,this.size);    //왼쪽,오른쪽으로 바꿀려면 this.point_x-this.size 로 바꾸면 됨
      //triangle(this.point_x,this.point_y,this.point_x+5,this.point_y-3,this.point_x+5,this.point_y+3)
    }
    else{
      circle(this.point_x,this.point_y,this.size);     //왼쪽,오른쪽으로 바꿀려면 this.point_x-this.size 로 바꾸면 됨
      //triangle(this.point_x + 5,this.point_y,this.point_x,this.point_y-3,this.point_x,this.point_y+3)
    }
    pop()
  }
}