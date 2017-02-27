/**********
ADD: Knight's path...
ADD: Amount remaining count
ADD: Win/lose condition
**********/
//For simplicity's sake, -1 is the value for BOMB

import de.bezier.guido.*;
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
public static int WINDOW_WIDTH;
public static int WINDOW_HEIGHT;
public final static int MAX_BOMBS=10;
public static boolean shiftHeld=false;

public int flags=0;
public int gameStatus;
private MSButton[][] buttons = new MSButton[NUM_ROWS][NUM_COLS]; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs;

void setup (){
    bombs=new ArrayList<MSButton>();
    size(800, 850);
    gameStatus=0;
    frameCount=0;
    WINDOW_WIDTH=width;
    WINDOW_HEIGHT=800;
    textSize(30);
    //required for guido buttons
    Interactive.make(this);
    
    for(int r=0; r<buttons.length;r++)
        for(int c=0; c<buttons[r].length; c++)
            buttons[r][c]=new MSButton(r, c);
    
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
    background(127);
    if(gameStatus==0){
        //draws the button array
        for(MSButton[] r:buttons)
            for(MSButton c:r)
                c.display();
    }
    textAlign(LEFT);
    text("Time: "+frameCount/60+" seconds", 0, height-18);
    textAlign(RIGHT);
    text(flags+"/"+MAX_BOMBS+" bombs flagged", width, height-18);
    if(gameStatus!=0){
        textAlign(CENTER);
        if(isWon())
            displayWinningMessage();
        else
            displayLosingMessage();
    }
}

public boolean isWon(){
    return false;
}
public void displayLosingMessage(){
    background(0);
    fill(250);
    gameStatus=2;
    text("YOU LOSE!\nClick to play again.", width/2, height/2);
}

public void displayWinningMessage(){
    background(0);
    fill(250);
    gameStatus=2;
    text("YOU WON!\nin "+frameCount/60.0+" seconds.\nClick to play again.", width/2, height/2);
    //noLoop();
}

void mousePressed(){
    if(gameStatus == 2)
        setup();
}
void keyPressed(){
    if(keyCode==SHIFT)
        shiftHeld=true;
}
void keyReleased(){
    if(keyCode==SHIFT)
        shiftHeld=false;
}
