import java.text.DecimalFormat;

static class Utils
{
  public static double pythagoras(Vec2 v1, Vec2 v2)
  {
    double triHeight = v2.y - v1.y;
    double triWidth = v2.x - v1.x;
    
    return Math.sqrt(triWidth * triWidth + triHeight * triHeight);
  }
  
  public static float clamp(float value, float min, float max)
  {
    return max(min(value, max), min);
  }
  
  public static double clamp(double value, double min, double max)
  {
    return Math.max(Math.min(value, max), min);
  }
}