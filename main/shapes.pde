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

class Circle extends Shape
{
  public double radius;
  
  public Circle(Vec2 position, double radius, int col)
  {
    super(position, col);
    this.radius = radius;
  }
  
  @Override
  public void render()
  {
    super.render();
    
    Vec2Float screenPosition = getScreenPos();
    float screenRadius = (float)(this.radius * mainCamera.zoom * width);
    
    ellipse(screenPosition.x, screenPosition.y, screenRadius, screenRadius);
  }
}

class Ellipse
{

}

class Rectangle
{

}