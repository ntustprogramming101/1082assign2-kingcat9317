PImage bgImg ,soilImg,hogImg,lifeImg,soldierImg,titleImg;
PImage cabbageImg,gameoverImg,hogRightImg,hogLeftImg,hogDownImg;
PImage restartHoverImg,restartNormalImg,startHoverImg,startNormalImg;

final int HOG_WH = 80;
final int LIFE_W = 50;
final int LIFE_H = 51;
final int SOIL_W = 640;
final int SOIL_H = 320;
final int SOLDIER_W = 80;
final int SOLDIER_H = 80;
final int CABBAGE_W = 80;
final int CABBAGE_H = 80;
final int GROUND = 80;
final int BUTTON_W = 144;
final int BUTTON_H = 60;
final int STEP = 80;

int soldierFloor=0;
//int soldierWalk=0;
float laserX=0,laserY=0;
int heartNum = 1;
int cabbageLocate,cabbageFloor=0;
int hogX,hogY = 0;
int cabbageX,cabbageY;
int soldierX,soldierY;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;

void setup() {
  size(640, 480, P2D);
  // Enter Your Setup Code Here
  bgImg = loadImage("img/bg.jpg");
  soilImg = loadImage("img/soil.png");
  hogImg = loadImage("img/groundhogIdle.png");
  lifeImg = loadImage("img/life.png");
  soldierImg = loadImage("img/soldier.png");
  cabbageImg = loadImage("img/cabbage.png");
  gameoverImg = loadImage("img/gameover.jpg");
  hogRightImg = loadImage("img/groundhogRight.png");
  hogLeftImg = loadImage("img/groundhogLeft.png");
  hogDownImg = loadImage("img/groundhogDown.png");
  restartHoverImg = loadImage("img/restartHovered.png");
  restartNormalImg = loadImage("img/restartNormal.png");
  startHoverImg = loadImage("img/startHovered.png");
  startNormalImg = loadImage("img/startNormal.png");
  titleImg = loadImage("img/title.jpg");
  
  //initail
  gameState =GAME_START;
  //soldier
  soldierFloor=floor(random(0,4));
  //cabbage
  cabbageLocate=floor(random(0,8));
  cabbageFloor=floor(random(0,4));
  cabbageX = cabbageLocate*GROUND;
  cabbageY = height-cabbageFloor*GROUND-CABBAGE_H;
  /*println(cabbageX,cabbageLocate);
  println(cabbageY,cabbageFloor);*/
  
  hogX = 4*STEP;
  hogY = 160-HOG_WH;
  soldierX=-SOLDIER_W;
  
  //frameRate(15);
  
}

void draw() {
  // Enter Your Code Here

	// Switch Game State
  switch(gameState){
    
		// Game Start
    case GAME_START:
      image(titleImg, 0, 0,width, height);
      if(mouseX > 248 && mouseX < 248+BUTTON_W
      && mouseY > 360 && mouseY < 360+BUTTON_H){
        image(startHoverImg, 248, 360,BUTTON_W,BUTTON_H);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormalImg, 248, 360,BUTTON_W,BUTTON_H);
      }
      hogX = 4*STEP;
      hogY = 160-HOG_WH;
      break;
      
		// Game Run
  case GAME_RUN:
    //draw
    //frameRate(60);
    image(bgImg, 0, 0,width, height);
    image(soilImg, 0, 160,SOIL_W, SOIL_H);
    image(cabbageImg,cabbageX,cabbageY,CABBAGE_W,CABBAGE_H);
    
    //Sun
    fill(253,184,19);
    strokeWeight(5);
    stroke(255,255, 0);
    ellipse(width-50,50,120,120);

    
    //draw heart
    if(heartNum>=0){
      for(int x=heartNum;x>=0;x--){
      image(lifeImg, 10+x*(20+LIFE_W), 10,LIFE_W, LIFE_H);
      }
    }
    //add heart//if hog crash cabbage
    if(hogX<cabbageX+CABBAGE_W && hogX+HOG_WH>cabbageX
    && hogY<cabbageY+CABBAGE_H && hogY+HOG_WH>cabbageY){
     heartNum++;
     cabbageX=-CABBAGE_W;
     cabbageY=-CABBAGE_H; 
    }
    //minus heart//if hog crash soilder
    if(hogX<soldierX+SOLDIER_W && hogX+HOG_WH>soldierX
    && hogY<soldierY+SOLDIER_H && hogY+HOG_WH>soldierY){
      if(heartNum>0){
        heartNum--;
        hogX = 4*STEP;
        hogY = 160-HOG_WH;
        upPressed = false;
        downPressed = false;
        rightPressed = false;
        leftPressed = false;
      }else{
        gameState=GAME_OVER;
      }
    }
   
    //soldier
    
    soldierY=height-soldierFloor*80-SOLDIER_H;
    image(soldierImg, soldierX, soldierY,SOLDIER_W,SOLDIER_H);
    
    if( soldierX<=width){
      soldierX+=1;
    }else{
      soldierX=-SOLDIER_W;
    }
    
    //hog move
    if(!keyPressed){
      image(hogImg,hogX,hogY,HOG_WH,HOG_WH);
    }else{
      if(upPressed){   
        frameRate(15);
        image(hogImg,hogX,hogY,HOG_WH,HOG_WH);
          hogY-=STEP;
          if(hogY<160){
            hogY=160;
          }
        }
        if(downPressed){ 
          frameRate(15);
          image(hogDownImg,hogX,hogY,HOG_WH,HOG_WH);
          hogY+=STEP; 
          if(hogY>height-HOG_WH){
            hogY=height-HOG_WH;
          }      
        }
        if(rightPressed){ 
          frameRate(15);
          image(hogRightImg,hogX,hogY,HOG_WH,HOG_WH);
          hogX+=STEP;
          if(hogX>width-HOG_WH){
            hogX=width-HOG_WH;
          }
        }
        if(leftPressed){ 
          frameRate(15);
          image(hogLeftImg,hogX,hogY,HOG_WH,HOG_WH);
          hogX-=STEP;
          if(hogX<0){
            hogX=0;
          }
        }
    }
      
    //grass
    strokeWeight(15);
    stroke(124,204,25);
    line(0, 160-15/2,width, 160-15/2);
      
    break;
		// Game Lose
  case GAME_OVER:
    image(gameoverImg, 0, 0,width, height);
      if(mouseX > 248 && mouseX < 248+BUTTON_W
      && mouseY > 360 && mouseY < 360+BUTTON_H){
        image(restartHoverImg, 248, 360,BUTTON_W,BUTTON_H);
        if(mousePressed){
          //reset
          heartNum=1;
          soldierFloor=floor(random(0,4));
          cabbageLocate=floor(random(0,8));
          cabbageFloor=floor(random(0,4));
          cabbageX = cabbageLocate*GROUND;
          cabbageY = height-cabbageFloor*GROUND-CABBAGE_H;
          hogX = 4*STEP;
          hogY = 160-HOG_WH;
          gameState = GAME_RUN;
        }
      }else{
        image(restartNormalImg, 248, 360,BUTTON_W,BUTTON_H);
      }
      break;
  }
}

void keyPressed(){
  if(key==CODED){
    switch(keyCode){
      case UP:
        upPressed=true;
        break;
      case DOWN:
        downPressed=true;
        break;
      case RIGHT:
        rightPressed=true;
        break;
      case LEFT:
        leftPressed=true;
        break;
    }
  }
}
////////
void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case UP:
        upPressed=false;
        break;
      case DOWN:
        downPressed=false;
        break;
      case RIGHT:
        rightPressed=false;
        break;
      case LEFT:
        leftPressed=false;
        break;
    }
  }
}
