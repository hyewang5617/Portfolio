class Shark{
    constructor(x,y,easing,character_image){
      this.x = x;
      this.y = y;
      this.easing = easing;
      this.character_image = character_image
    }
    
  draw() {
    let targetX = mouseX;
    let dx = targetX - this.x;
    let targetY = mouseY;
    let dy = targetY - this.y;
    
    if(mouseX < width/2+200 && mouseX > width/2-200&&
        mouseY < height/2+200 && mouseY > height/2-200){
        this.x += dx * this.easing;//상어의 x좌표
        this.y += dy * this.easing; //상어의 y좌표
    }
    
    push()
    fill(0,0,255)
    circle(this.x, this.y, 80);
    image(character_image,this.x-97,this.y-70,198,126)
    pop()
    
    }
  }