class Timer{
    constructor(sec){
        this.sec = sec; 
        this.score = 0;
        this.timer;
    }
    
    draw(){
        if(mouseX < width/2+200 && mouseX > width/2-200&&
            mouseY < height/2+200 && mouseY > height/2-200){
                this.sec++
                this.score++
        }
        else{
            this.sec--
            this.score++
        }

        if((this.sec) <= 0){  //끝났을때 
            push()
            this.sec--
            textSize(70)
            fill("red")
            text("0",70,70)
            text(this.score,70,180)
            pop()
            push()
            textSize(100)
            text("game \n over", width/2,height/2)
            pop()
        }
        else if((this.sec) <= 10){  //10초전 
            push()
            textSize(70)
            fill("red")
            text(this.sec,70,70)
            pop()
        }
        else{
            textSize(50)
            text(this.sec,70,70)
            text(this.score,70,180)
        }
        timer = setTimeout(this.GameOver, this.sec*1000);
        
            
    }
    GameOver(){
        
    }

}