public Camera mainCamera = new Camera(new Vec2(0, 0), 0.5);
public double aspectRatio;

public ArrayList<Shape> shapes = new ArrayList<Shape>();

void setup()
{
  fullScreen();
  
  colorMode(HSB, 1.0f, 1.0f, 1.0f);
  
  for(int i = 1000; i > -1000; i--)
  {
    double f = pow(1.02, i);
    shapes.add(new Circle(new Vec2(cos(i / 5.5), sin(i / 5.5)).mul(f), 0.3 * f, color((abs(i) / 500f + random(0f, 0.05f)) % 1f, 1, 1)));
  }
  
  fill(0);
  noStroke();
  
  aspectRatio = width / (double)height;
}

void draw()
{
  background(color(0, 0, 1));
  
  if(mousePressed)
  {

  }
  
  if(keyPressed)
  {
    if(keyCode == UP)
    {
      mainCamera.moveRelative(new Vec2(0, -0.6 / frameRate));
    }
    if(keyCode == RIGHT)
    {
      mainCamera.moveRelative(new Vec2(-0.6 / frameRate, 0));
    }
    if(keyCode == LEFT)
    {
      mainCamera.moveRelative(new Vec2(0.6 / frameRate, 0));
    }
    if(keyCode == DOWN)
    {
      mainCamera.moveRelative(new Vec2(0, 0.6 / frameRate));
    }
    
    if(key == 'w')
    {
      mainCamera.zoomIn(1.025);
    }
    if(key == 's')
    {
      mainCamera.zoomOut(1.025);
    }
  }
  
  for(Shape s : shapes)
  {
    s.render();
  }
  
  fill(0);
  textSize(32);
  textAlign(LEFT, TOP);
  text("Width | " + Utils.formatDistance(mainCamera.getRange()) + "\n" + 
      "Distance from Center | " + Utils.formatDistance(Utils.pythagoras(new Vec2(0, 0), mainCamera.position)), 0, 0);
}

void mouseWheel(MouseEvent e)
{
  int value = e.getCount();
  boolean scrolledUp, scrolledDown;
  
  scrolledUp = value == -1;
  scrolledDown = !scrolledUp;
  
  if(scrolledUp)
  {
    mainCamera.zoomIn(1.1);
  }
  if(scrolledDown)
  {
    mainCamera.zoomOut(1.1);
  }
}