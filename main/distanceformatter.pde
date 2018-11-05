public static class DistanceFormatter
{
  private static DecimalFormat formatter = new DecimalFormat("#,##0.00");
  
  private static String[] distances_small = {"mm", "µm", "nm", "pm", "fm", "at", "zm", "ym"};
  private static String[] distances_big = {"m", "Km", "Mm", "Gm", "Tm", "Pm", "Em"};
  
  private static final double DISTANCE_LIGHT_YEAR = 9.461e+15;
  private static final double DISTANCE_PLANCK_LENGTH = 1.6e-35;
  
  public static String format(double number)
  {
    if(number >= DISTANCE_LIGHT_YEAR)
    {
      return formatter.format(number / DISTANCE_LIGHT_YEAR) + " Light Years";
    }
    if(number >= 1)
    {
      int order = (int)Math.log10(number) / 3;
      return formatter.format(Math.pow(10, Math.log10(number) % 3)) + distances_big[order];
    }
    else if(number >= 0.01)
    {
      return formatter.format(number * 100.0) + "cm";
    }
    else if(number >= 1e-24)
    {
      int order = (int)-Math.log10(number) / 3;
      return formatter.format(Math.pow(10, Math.log10(number) % 3 + 3)) + distances_small[order]; //0 to 3 instead of -3 to 0
    }
    else if(number > 0)
    {
        return formatter.format(number / DISTANCE_PLANCK_LENGTH) + " Planck Lengths";
    }
    else
    {
      return formatter.format(number) + "m";
    }
  }
}