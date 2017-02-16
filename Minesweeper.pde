

import de.bezier.guido.*;
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
public static int WINDOW_WIDTH;
public static int WINDOW_HEIGHT;
public final static int MAX_BOMBS=50;

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
            c.display();
/*
    if(isWon())
        displayWinningMessage();*/
}

public boolean isWon(){
    //your code here
    return true;
}
public void displayLosingMessage(){
    background(0);
    fill(250);
    text(":(", width/2, height/2);
    noLoop();
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


    public void mousePressed(){
        if(mouseButton==RIGHT)
            marked = !marked;
        else if(!clicked){
            this.clicked=true;
            //stops recursion if it hits a number>0
            if(!(buttons[r][c].getLabel().equals("0"))) return;
            
            //recursively reveals nearby tiles
            buttons[r][c+1].mousePressed();
            buttons[r][c-1].mousePressed();
            buttons[r+1][c].mousePressed();
            buttons[r-1][c].mousePressed();
            
            if(this.label.equals("BOMB"))
                displayLosingMessage();
        }
    }

    public void display() {    
        if (marked)
            fill(0, 200, 0);
        // else if( clicked && bombs.contains(this) ) 
        //     fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 250 );
        rect(x, y, width, height);
        fill(0);
        //if(this.clicked)
            text((label.equals("0")?"": label),x+width/2,y+height/2);
    }

    public int countBombs(){
        int numBombs = 0;
        for(MSButton bomb:bombs)
            if(abs(bomb.r-this.r)<=1&&abs(bomb.c-this.c)<=1)
                numBombs++;
        return numBombs;
    }

    //set and get
        //LABELS
        public void setLabel(String newLabel){label = newLabel;}
        public String getLabel(){return label;}
        //
        public boolean isMarked(){return marked;}
        public boolean isClicked(){return clicked;}
}



