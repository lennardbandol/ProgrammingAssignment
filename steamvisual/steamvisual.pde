ArrayList<Steam> data = new ArrayList<Steam>();

void setup()
{
  size( 800,800 );
  loadData();
}

void loadData()
{
  String[] lines = loadStrings("SteamData.csv");
  for(int i = 0; i <lines.length ; i++)
  {
    println(lines);
    Steam steam = new Steam(lines[i]);
    data.add(steam);
  }
}

void draw()
{

  
}





