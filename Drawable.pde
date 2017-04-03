public class Drawable{
    private int r, c;
    private float x,y;
    private float width, height;
    private boolean clicked, marked;
    private int label;

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
        if(clicked && label>0)
            text(label,x+width/2,y+height/2);
    }


}