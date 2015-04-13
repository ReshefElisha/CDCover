int size = 800;
int cFill = 0;
int[][] grid = new int[size][size];
int counter = 0;
ArrayList<DrawObj> objList = new ArrayList<DrawObj>();

void setup()
{
 colorMode(HSB, 360, 100,100);
 size(size,size);
 background(#FFFFFF);
 noFill();
 noSmooth();
}

void draw()
{
  if(mousePressed)
  {
    int rType = int(random(5));
    if(rType == 0)
    {
      int startX = int(random(size))-size/2;
      int startY = int(random(size))*2-size/2;
      int endX = int(random(size))+size/2;
      int endY = int(random(size))*2-size/2;
      line(startX,startY,endX,endY);
      objList.add(new DrawObj(rType, startX, startY, endX, endY));
    }
    else
    {
      int rX = int(random(size));
      int rY = int(random(size));
      int rRad = int(random(size));
      if(cFill == 9) fill(#FFFFFF);
      ellipse(rX, rY, rRad,rRad);
      objList.add( new DrawObj(rType, rX, rY, rRad, cFill));
      noFill();
      cFill++;
      cFill %= 10;
    }
  }
}

void keyPressed()
{
  if(key == 110)
  {
    fill(#FFFFFF);
    stroke(#FFFFFF);
    rect(0,0,size,size);
    noFill();
    stroke(0);
    grid = new int[size][size];
  }
  else
    randomFill();
}

void randomFill()
{
  int r = 0;
  color c = color(#FFFFFF);
  loadPixels();
  for(int x = 0; x<size; x++)
  {
    for(int y = 0; y<size; y++)
    {
      if(pixels[y*width+x]==(color(#FFFFFF)))
      {
        if(r == 0) {c = color(int(random(50))+220,int(random(50))+50,int(random(70))+30);println("New Color");}
        r = fillAround(x,y,c);
        counter = 0;
      }
    }
  }
  updatePixels();
  //smooth();
  /*for( DrawObj d : objList)
  {
    int rType = d.getT();
    if(rType == 0)
    {
      int startX = d.getA1();
      int startY = d.getA2();
      int endX = d.getA3();
      int endY = d.getA4();
      line(startX,startY,endX,endY);
    }
    else
    {
      int rX = d.getA1();
      int rY = d.getA2();
      int rRad = d.getA3();
      int cFill = d.getA4();
      //if(cFill == 9) fill(#FFFFFF);
      ellipse(rX, rY, rRad,rRad);
      noFill();
    }
  }*/
  println(counter);
}

int fillAround(int x, int y, color c)
{
  counter++;
  //set(x,y,c);
  pixels[y*width+x] = c;
  //println("("+x+","+y+"): "+counter);
  if(counter>7000){ return 1;}
  ArrayList<Point> points = getPointsAround(x,y);
  int r = 0;
  for(int i = 0; i<points.size(); i++)
  {
    r = fillAround(points.get(i).getX(), points.get(i).getY(),c);
  }
  return r;
}

ArrayList<Point> getPointsAround(int x, int y)
{
  ArrayList<Point> ptList = new ArrayList<Point>();
  if(x-1>-1 && grid[x-1][y] == 0 && brightness(get(x-1,y)) > 50)
  {
    grid[x-1][y] = 1;
    ptList.add(new Point(x-1,y));
  }
  if(x+1<size && grid[x+1][y] == 0 && brightness(get(x+1,y)) > 50)
  {
    grid[x+1][y] = 1;
    ptList.add(new Point(x+1,y));
  }
  if(y-1>-1 && grid[x][y-1] == 0 && brightness(get(x,y-1)) > 50)
  {
    grid[x][y-1] = 1;
    ptList.add(new Point(x,y-1));
  }
  if(y+1<size && grid[x][y+1] == 0 && brightness(get(x,y+1)) > 50)
  {
    grid[x][y+1] = 1;
    ptList.add(new Point(x,y+1));
  }
  return ptList;
}

class Point
{
  int x,y;
  public Point(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  public int getX()
  {return x;}
  
  public int getY()
  {return y;}
}

class DrawObj
{
  int t, a1,a2,a3,a4;
  public DrawObj(int t, int a1, int a2, int a3, int a4)
  {
    this.t = t;
    this.a1 = a1;
    this.a2 = a2;
    this.a3 = a3;
    this.a4 = a4;
  }
  
  public int getT()
  {
    return t;
  }
  
  public int getA1()
  {
    return a1;
  }
  
  public int getA2()
  {
    return a2;
  }
  
  public int getA3()
  {
    return a3;
  }
  
  public int getA4()
  {
    return a4;
  }
}
