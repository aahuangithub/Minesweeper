//For simplicity's sake, -1 is the value for BOMB

import de.bezier.guido.*;
//sets how big(rows/cols-wise) the board will be
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
//sets how big(pixel-wise) the board will be
public static int WINDOW_WIDTH;
public static int WINDOW_HEIGHT;
//
public static int MAX_BOMBS=15;
public static boolean firstRun=true;

public boolean gameEnd;
public static int bombsFlagged;
public static int endTime;
public static boolean isLost;

public static boolean shiftHeld=false;

public int flagsUsed=0;
public int gameMode=0;
private MSButton[][] buttons = new MSButton[NUM_ROWS][NUM_COLS]; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs;
//required to interact with js (otherwise use path[0].length)
public int gamemodeLength=0;

private static final String[] PATHS = {
"https://i.imgur.com/QpNMNfg.png",
"https://i.imgur.com/9jWDgqC.png",
"https://i.imgur.com/weRSO4O.png", 
"https://i.imgur.com/tX4qOAa.png", 
};

/*
this code can be modified the reveal path
white is unrevealed, red is revealed, black center is click
*/

public static PImage img;
public static int[][] path;

public int loadPath(){
    img = loadImage(PATHS[gameMode]);
    path=new int[img.width][img.height];
    image(img, 0, 0);
    for(int x=0; x<img.width; x++){
        int[] temp=new int[img.height];
        for(int y=0; y<img.height; y++){
            temp[y]=((get(x,y)==-1237980?1:0));
        }
        path[x]=temp;
    }
    return img.height;
}

void setup (){
    loadPath();
    size(800, 850);
    bombs=new ArrayList<MSButton>();
    WINDOW_WIDTH=width;
    WINDOW_HEIGHT=800;
    textSize(30);
    gameEnd=false;
    bombsFlagged=0;
    endTime=0;
    isLost=false;

    flagsUsed=0;
    frameCount=0;
    //required for guido buttons
    Interactive.make(this);
    if(firstRun){
        firstRun=false;
        for(int r=0;r<buttons.length;r++)
            for(int c=0; c<buttons[r].length; c++){
                buttons[r][c]=new MSButton(r, c);
            }
    }else{
        for(MSButton r[]:buttons)
            for(MSButton c:r)
                c.resetButton();
    }
    setBombs();
    for(MSButton[] r:buttons)
        for(MSButton c:r)
            if(c.getLabel()!=-1)
                c.setLabel(c.countBombs());
}

public void setBombs(){
    while(bombs.size()<MAX_BOMBS){
        int r=(int)(Math.random()*NUM_ROWS);
        int c=(int)(Math.random()*NUM_COLS);
        if(buttons[r][c].getLabel()!=-1){
            buttons[r][c].setLabel(-1);
            bombs.add(buttons[r][c]);
        }
    }
}

public void draw (){
    switch(gameMode){
        case 0:
            background(127);
            break;
        case 1:
            background(200, 100, 100);
            break;
        case 2:
            background(100, 200, 100);
            break;
        case 3:
            background(100, 150, 200);
            break;
    }
    
    if(!gameEnd)
        //draws the button array
        for(MSButton[] r:buttons)
            for(MSButton c:r)
                c.display();
    
    textAlign(LEFT);
    text("Time: "+(int)(frameCount/60)+" seconds", 0, height-18);
    textAlign(RIGHT);
    text(flagsUsed+"/"+MAX_BOMBS+" bombs flagged", width, height-18);
    if(isWon())
        displayWinningMessage();
    for(MSButton bomb:bombs) //there's probs a more efficient way to do this
        if(bomb.isClicked())
            displayLosingMessage();
}

public boolean isWon(){ 
    if(bombsFlagged==MAX_BOMBS)
        return true;
    return false;
}
public void displayLosingMessage(){
    textAlign(CENTER);
    background(0);
    fill(250);
    text("YOU LOSE!\nClick to play again.", width/2, height/2);
    gameEnd=true;
}

public void displayWinningMessage(){
    textAlign(CENTER);
    background(0);
    fill(250);
    if(endTime==0)
        endTime=frameCount;
    gameEnd=true;
    text("YOU WON!\nin "+(int)(endTime/60)+" second"+(frameCount>120?"s.":".")+"\nClick to play again.", width/2, height/2);
}

void mousePressed(){
    if(gameEnd)
        setup();
}
void keyPressed(){
    if(keyCode==SHIFT)
        shiftHeld=true;
    if(keyCode==LEFT && MAX_BOMBS>2){
        MAX_BOMBS--;
        setup();
    }
    if(keyCode==RIGHT && MAX_BOMBS<0.9*NUM_ROWS*NUM_COLS){
        MAX_BOMBS++;
        setup();
    }
    if(key==' '){
        if(gameMode<3)gameMode++;
        else gameMode=0;
        setup();
    };
}
void keyReleased(){
    if(keyCode==SHIFT)
        shiftHeld=false;
}