import javax.swing.JColorChooser;
import java.awt.Color;

public Camera mainCamera = new Camera(new Vec2(0, 0), 0.5);
public double aspectRatio;

public ArrayList<Shape> shapes = new ArrayList<Shape>();

public Vec2 relativeShapeSize = new Vec2(0.01f, 0.01f);

Vec2 mouseDeltaStart = new Vec2(0, 0), mouseDelta = new Vec2(0, 0);

public Color shapeColor = Color.BLACK;

float keyPressTime = 0f;

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
  mouseDelta = mouseDeltaStart.sub(mouseX, mouseY);

  mouseDeltaStart = new Vec2(mouseX, mouseY);
  
  float deltaTime = 1 / frameRate;
  
  background(color(0, 0, 1));
  
  noStroke();
  
  if(mousePressed && mouseButton == LEFT)
  {
    placeShape();
  }
  
  if(keyPressed)
  {
    keyPressTime += deltaTime;
    
    if(keyCode == UP)
    {
      mainCamera.moveRelative(new Vec2(0, -min(1.5f, 0.3 + keyPressTime * 0.2f) / frameRate));
    }
    if(keyCode == RIGHT)
    {
      mainCamera.moveRelative(new Vec2(-min(1.5f, 0.3 + keyPressTime * 0.2f) / frameRate, 0));
    }
    if(keyCode == LEFT)
    {
      mainCamera.moveRelative(new Vec2(min(1.5f, 0.3 + keyPressTime * 0.2f) / frameRate, 0));
    }
    if(keyCode == DOWN)
    {
      mainCamera.moveRelative(new Vec2(0, min(1.5f, 0.3 + keyPressTime * 0.2f) / frameRate));
    }
    
    if(key == 'w')
    {
      mainCamera.zoomIn(pow(min(10, 2 + keyPressTime), deltaTime));
    }
    if(key == 's')
    {
      mainCamera.zoomOut(pow(min(10, 2 + keyPressTime), deltaTime));
    }
    
    if(key == 'r')
    {
      relativeShapeSize.x -= min(0.25, 0.05 + 0.1 * keyPressTime) * deltaTime;
    }
    if(key == 't')
    {
      relativeShapeSize.x += min(0.25, 0.05 + 0.1 * keyPressTime) * deltaTime;
    }
    
    if(key == 'f')
    {
      relativeShapeSize.y -= min(0.25, 0.05 + 0.1 * keyPressTime) * deltaTime;
    }
    if(key == 'g')
    {
      relativeShapeSize.y += min(0.25, 0.05 + 0.1 * keyPressTime) * deltaTime;
    }
    
    relativeShapeSize = new Vec2(Utils.clamp(relativeShapeSize.x, 0.005, 0.5), Utils.clamp(relativeShapeSize.y, 0.005, 0.5));
    
    
  }
  
  
  for(Shape s : shapes)
  {
    s.render();
  }
  
  fill(shapeColor.getRGB(), 0.5f);
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
  
  fill(0);
  textSize(32);
  textAlign(LEFT, TOP);
  text("Distance from Center | " + DistanceFormatter.format(Utils.pythagoras(new Vec2(0, 0), mainCamera.position)), 0, 0);
      
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  for(float x = 0, i = 0; x < width; x += width / 10f, i++)
  {
    fill(i % 2 == 0 ? 0 : color(0, 0, 1, 1));
    rect(x, height - 30, width / 10f, 30);
  }
  rectMode(CENTER);
  
  textAlign(CENTER, BOTTOM);
  fill(0);
  textSize(40);
  text("<- " + DistanceFormatter.format(mainCamera.getRange()) + " ->", width / 2, height - 40);
      
  fill(shapeColor.getRGB(), 0.5f);
  
  
  
}

void keyPressed()
{
  if(key == 'd')
  {
    drawType = DrawType.values()[(drawType.ordinal() + 1) % DrawType.values().length];
  }
  if(key == 'c')
  {
    shapeColor = chooseColor();
  }
  if(key == 'o')
  {
    mainCamera.position = new Vec2(0, 0);
  }
}

void keyReleased()
{
  keyPressTime = 0f;
}

void mousePressed(MouseEvent e)
{
  if(e.getButton() == LEFT)
  {
   //placeShape();
  }
  
}

void mouseDragged(MouseEvent e)
{
  if(e.getButton() == RIGHT)
  {
    Vec2 translation = new Vec2(mouseDelta.x / width / -4 * mainCamera.getRange(),
                                mouseDelta.y / width / 4 * mainCamera.getRange());
    mainCamera.move(translation);
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

void placeShape()
{
    int col = shapeColor.getRGB();
  
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

Color chooseColor()
{
  Color col = JColorChooser.showDialog(null, "Choose Color", shapeColor);
  
  return col != null ? col : shapeColor;
}