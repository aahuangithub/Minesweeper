/**********
FIX: Endscreen -> replay transition
FIX: Clean up redundant variables
FIX: Split up program into multiple files (for cleaniness)
ADD: score count
ADD: Amount remaining count
**********/

import de.bezier.guido.*;
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
public static int WINDOW_WIDTH;
public static int WINDOW_HEIGHT;
public final static int MAX_BOMBS=50;

public boolean game;
public int numRevealed;
private MSButton[][] buttons = new MSButton[NUM_ROWS][NUM_COLS]; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs;

void setup (){
    game=true;
    numRevealed=0;
    bombs=new ArrayList<MSButton>();

    size(800, 800);
    textAlign(CENTER,CENTER);
    WINDOW_WIDTH=width;
    WINDOW_HEIGHT=height;
    textSize(36);
    //required for guido buttons
    Interactive.make(this);
    
    for(int r=0; r<buttons.length;r++)
        for(int c=0; c<buttons[r].length; c++)
            buttons[r][c]=new MSButton(r, c);
    
    setBombs();
    for(MSButton[] r:buttons)
        for(MSButton c:r)
            if(!c.getLabel().equals("BOMB"))
                c.setLabel(Integer.toString(c.countBombs()));
}

public void setBombs(){
    while(bombs.size()<MAX_BOMBS){
        int r=(int)(Math.random()*NUM_ROWS);
        int c=(int)(Math.random()*NUM_COLS);
        if(!buttons[r][c].getLabel().equals("BOMB")){
            buttons[r][c].setLabel("BOMB");
            bombs.add(buttons[r][c]);
        }
    }
}

public void draw (){
    background(0);

    //draws the button array
    for(MSButton[] r:buttons)
        for(MSButton c:r)
            c.display();

    if(!game){
        if(isWon())
            displayWinningMessage();
        else
            displayLosingMessage();
        //call setup() to restart
    }
}

public boolean isWon(){
    //fix this function
    if(numRevealed==NUM_COLS*NUM_ROWS-MAX_BOMBS)
        return true;
    return false;
}
public void displayLosingMessage(){
    background(0);
    fill(250);
    text("YOU LOSE!\nClick to play again.", width/2, height/2);
}
public void displayWinningMessage(){
    background(0);
    fill(250);
    text("YOU WON!", width/2, height/2);
    //noLoop();
}

