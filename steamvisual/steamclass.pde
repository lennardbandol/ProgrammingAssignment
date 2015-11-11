class Steam
{
  String game;
  int players;
  color colour;
  
  Steam(String line)
  {
    String[] parts = line.split(",");
    game = parts[0];
    players = Integer.parseInt(parts[1]);
  }
}
