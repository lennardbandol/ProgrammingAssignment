class Steam
{
  String game;
  int players;
  String link;
  color colour;
  
  Steam(String line)
  {
    String[] parts = line.split(",");
    game = parts[0];
    players = Integer.parseInt(parts[1]);
    colour = color(random(180),random(180),random(180));
    link = parts[2];
  }
}
