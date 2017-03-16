
//For simplicity's sake, -1 is the value for BOMB
public class MSButton{
    private int r, c;
    private float x,y;
    private float width, height;
    private boolean clicked, marked;
    private int label;
    private Tuple[][] transformedPath = new Tuple[path.length][path[0].length];

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
        if(mouseButton==RIGHT || shiftHeld){
            marked = !marked;
            if(label==-1) bombsFlagged+=(marked?1:-1);
            flagsUsed++;
        }
        else if(!clicked){
            clicked=true;
            if(marked){
                marked=false; 
                flagsUsed--;
            }
            numRevealed++;
            //stops recursion if it hits a number>0
            /*
            if(getLabel()==0){
                //recursively reveals nearby tiles
                if(c>0)
                    buttons[r][c-1].mousePressed();
                if(c<buttons[r].length-1)
                    buttons[r][c+1].mousePressed();
                if(r>0)
                    buttons[r-1][c].mousePressed();
                if(r<buttons.length-1)
                    buttons[r+1][c].mousePressed();
                if(c>0&&r>0) 
                    buttons[r-1][c-1].mousePressed();
                if(c<buttons[r].length-1 && r<buttons.length-1) 
                    buttons[r+1][c+1].mousePressed();
            }
            */
              for(Tuple[] row:transformedPath){
                for(Tuple t:row)
                    if(t.getR()>=0 && t.getC()>=0)
                        if(buttons[t.getR()][t.getC()].getLabel()==0)
                            buttons[t.getR()][t.getC()].mousePressed();
            }
            if(label==-1)
                isLost=true;
        }
    }

    public void display() {  
        textAlign(CENTER, CENTER);  
        if (marked)
            fill(0, 200, 0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 250 );
        rect(x, y, width, height);
        fill(0);
       //if(clicked && label!=0)
            text(label,x+width/2,y+height/2);
    }

    public int countBombs(){
        int numBombs = 0;
        int midRow=path.length/2;
        int midCol=path[0].length/2;

        for(int i=0; i<path.length; i++){
            for(int col=0; col<path[i].length;col++){
                if(path[i][col]!=0)
                    transformedPath[i][col] = new Tuple(i-midRow+r, col-midCol+c);
                else
                    transformedPath[i][col] = new Tuple(-1, -1);
            }
        }

        for(MSButton bomb:bombs)
            for(Tuple row[]:transformedPath)
                for(Tuple t:row)
                    if(bomb.getC()==t.getC() && bomb.getR()==t.getR())
                        numBombs++;
            //there's probably a more efficient way to do this...
        
        return numBombs;
    }

    //set and get
        //LABELS
        public int getR(){return r;}
        public int getC(){return c;}
        public void setLabel(int newLabel){label = newLabel;}
        public int getLabel(){return label;}
        //BOOLS
        public boolean isMarked(){return marked;}
        public boolean isClicked(){return clicked;}
}



