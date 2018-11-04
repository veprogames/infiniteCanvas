import java.text.DecimalFormat;

static class Utils
{
  private static DecimalFormat formatter = new DecimalFormat("#,##0.00");
  
  private static String[] distances_small = {"mm", "µm", "nm", "pm", "fm"};
  private static String[] distances_big = {"m", "Km", "Mm", "Gm"};
  
  public static String formatDistance(double number)
  {
    if(number >= 1)
    {
      int order = (int)Math.log10(number) / 3;
      return formatter.format(Math.pow(10, Math.log10(number) % 3)) + distances_big[order];
    }
    else if(number >= 0.01)
    {
      return formatter.format(number * 100.0) + "cm";
    }
    else if(number > 0)
    {
      int order = (int)-Math.log10(number) / 3;
      return formatter.format(Math.pow(10, Math.log10(number) % 3 + 3)) + distances_small[order]; //0 to 3 instead of -3 to 0
    }
    else if(number == 0)
    {
      return "zero";
    }
    else
    {
      return formatter.format(number) + "m";
    }
  }
  
  public static double pythagoras(Vec2 v1, Vec2 v2)
  {
    double triHeight = v2.y - v1.y;
    double triWidth = v2.x - v1.x;
    
    return Math.sqrt(triWidth * triWidth + triHeight * triHeight);
  }
}