

import de.bezier.guido.*;
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
public static int WINDOW_WIDTH;
public static int WINDOW_HEIGHT;
public final static int MAX_BOMBS=20;

private MSButton[][] buttons = new MSButton[NUM_ROWS][NUM_COLS]; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>();

void setup (){
    size(800, 800);
    textAlign(CENTER,CENTER);
    WINDOW_WIDTH=width;
    WINDOW_HEIGHT=height;

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
            c.draw();

    //??? cannot draw on top of buttons???
    rect(0, 0, 233, 232);
    if(isWon())
        displayWinningMessage();
}

public boolean isWon(){
    //your code here
    return true;
}
public void displayLosingMessage(){
    background(0);
    fill(250);
    text("YOU WON!", width/2, height/2);
    //noLoop();
}
public void displayWinningMessage(){
    background(0);
    fill(250);
    text("YOU WON!", width/2, height/2);
    //noLoop();
}

public class MSButton{
    private int r, c;
    private float x,y, width, height;
    //for some reason changing the names of width and height variables doesn't work
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc ){
        width = WINDOW_WIDTH/NUM_COLS;
        height = WINDOW_HEIGHT/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add(this); // register it with the manager
    }
    public boolean isMarked(){
        //flags!
        return marked;
    }
    public boolean isClicked(){
        //number!
        return clicked;
    }
    // called by manager
    
    public void mousePressed(){
        if(mouseButton==RIGHT)
            marked = true;
        else
            clicked = true;
    }

    public void draw () {    
        if (marked)
            fill(0, 200, 0);
        // else if( clicked && bombs.contains(this) ) 
        //     fill(255,0,0);
        else if(clicked)
            fill( 127 );
        else 
            fill( 250 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel){
        label = newLabel;
    }
    public String getLabel(){
        return label;
    }
    public boolean isValid(int r, int c){
        //your code here
        return false;
    }
    public int countBombs(){
        int numBombs = 0;
        //checks nearby bombs
        return numBombs;
    }
}



