//For simplicity's sake, -1 is the value for BOMB
public class MSButton{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private int label;
    
    public MSButton (int rr, int cc){
        width = WINDOW_WIDTH/NUM_COLS;
        height = WINDOW_HEIGHT/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        marked = clicked = false;
        Interactive.add(this); // register it with the manager
    }


    public void mousePressed(){
        if(mouseButton==RIGHT)
            marked = !marked;
            //if(!this.clicked) numRevealed++;
        else if(!clicked){
            this.clicked=true;
            //if(!this.marked) numRevealed++;
            if(this.marked) this.marked=false;
            //stops recursion if it hits a number>0
            if(this.getLabel()==0){
                //recursively reveals nearby tiles
                if(this.c>0)
                    buttons[r][c-1].mousePressed();
                if(this.c<buttons[r].length-1)
                    buttons[r][c+1].mousePressed();
                if(this.r>0)
                    buttons[r-1][c].mousePressed();
                if(this.r<buttons.length-1)
                    buttons[r+1][c].mousePressed();
            }
            if(this.label==-1)
                gameStatus=1;
        }
    }

    public void display() {    
        if (marked)
            fill(0, 200, 0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 250 );
        rect(x, y, width, height);
        fill(0);
        if(this.clicked && this.label!=0)
            text(label,x+width/2,y+height/2);
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
        public void setLabel(int newLabel){label = newLabel;}
        public int getLabel(){return label;}
        //BOOLS
        public boolean isMarked(){return marked;}
        public boolean isClicked(){return clicked;}
}



