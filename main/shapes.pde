class Shape
{
  public Vec2 position;
  public int shapeColor;
  
  public Shape(Vec2 position)
  {
    this.position = position;
  }
  
  public Shape(Vec2 position, int col)
  {
    this.position = position;
    this.shapeColor = col;
  }
  
  protected Vec2Float getScreenPos()
  {
    Vec2 pos = mainCamera.worldToScreenPoint(this.position);
    return new Vec2Float((float)pos.x, (float)pos.y);
  }
  
  public void render()
  {
    fill(shapeColor);
  }
}

class Ellipse extends Shape
{
  public Vec2 radius;
  
  public Ellipse(Vec2 position, Vec2 radius, int col)
  {
    super(position, col);
    this.radius = radius;
  }
  
  @Override
  public void render()
  {
    super.render();
    
    Vec2Float screenPosition = getScreenPos();
    Vec2Float screenRadius = new Vec2Float((float)(this.radius.x * mainCamera.zoom * width), (float)(this.radius.y * mainCamera.zoom * width));
    
    ellipse(screenPosition.x, screenPosition.y, screenRadius.x, screenRadius.y);
  }
}

class Rectangle extends Shape
{
  public Vec2 size;
  
  public Rectangle(Vec2 position, Vec2 size, int col)
  {
    super(position, col);
    this.size = size;
  }
  
  @Override
  public void render()
  {
    super.render();
    
    Vec2Float screenPosition = getScreenPos();
    Vec2Float screenRadius = new Vec2Float((float)(this.size.x * mainCamera.zoom * width), (float)(this.size.y * mainCamera.zoom * width));
    
    rect(screenPosition.x, screenPosition.y, screenRadius.x, screenRadius.y);
  }
}

public void addShape(Shape shape)
{
    shapes.add(shape);
}