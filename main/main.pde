public Camera mainCamera = new Camera(new Vec2(0, 0), 0.5);
public double aspectRatio;

public ArrayList<Shape> shapes = new ArrayList<Shape>();

public Vec2 relativeShapeSize = new Vec2(0.01, 0.01);

enum DrawType{
  CIRCLE, RECTANGLE
}

public DrawType drawType = DrawType.CIRCLE;

void setup()
{
  fullScreen();
  
  colorMode(HSB, 1.0f, 1.0f, 1.0f, 1.0f);
  rectMode(CENTER);
  
  fill(0);
  noStroke();
  
  aspectRatio = width / (double)height;
}

void draw()
{
  float deltaTime = 1 / frameRate;
  
  background(color(0, 0, 1));
  
  int col = color((millis() / 2000.0) % 1, 1, 1, 1f);
  
  if(mousePressed)
  {
    Vec2 position = mainCamera.screenToWorldPos(mouseX, mouseY);
    Vec2 size = relativeShapeSize.mul(mainCamera.getRange());
    
    switch(drawType)
    {
      case CIRCLE:
          addShape(new Ellipse(position, size, col));
          break;
      case RECTANGLE:
          addShape(new Rectangle(position, size, col));
          break;
      default:
            break;
    }
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
      mainCamera.zoomIn(pow(3, deltaTime));
    }
    if(key == 's')
    {
      mainCamera.zoomOut(pow(3, deltaTime));
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
      
  fill((millis() / 2000.0) % 1, 1, 1, 0.5f);
  
  switch(drawType)
  {
    case CIRCLE:
        ellipse(mouseX, mouseY, width * (float)relativeShapeSize.x, width * (float)relativeShapeSize.y);
        break;
    case RECTANGLE:
        rect(mouseX, mouseY, width * (float)relativeShapeSize.x, width * (float)relativeShapeSize.y);
        break;
    default:
        break;
  }
}

void keyPressed()
{
  if(key == 'd')
  {
    drawType = DrawType.values()[(drawType.ordinal() + 1) % DrawType.values().length];
  }
}

void mouseWheel(MouseEvent e)
{
  int value = e.getCount();
  boolean scrolledUp, scrolledDown;
  
  scrolledUp = value == -1;
  scrolledDown = !scrolledUp;
  
  if(scrolledUp)
  {
    mainCamera.zoomIn(1.2);
  }
  if(scrolledDown)
  {
    mainCamera.zoomOut(1.2);
  }
}