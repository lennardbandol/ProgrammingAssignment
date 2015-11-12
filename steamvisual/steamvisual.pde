ArrayList<Steam> data = new ArrayList<Steam>();
ArrayList<Steam> sorted = new ArrayList<Steam>();
ArrayList<Steam> temp = new ArrayList<Steam>();
int[] asc_index = new int[data.size()];

void setup()
{
  size( 800, 600 );
  smooth();
  loadData();
  drawTrendLineGraph(data, "Steam Graph");
}

int which = 0;
void draw()
{
  if (option == 0)
  {
    drawmenu();
  }
  if ( option == 1)
  {
    drawBarGraph();
  }
  if (option == 2 )
  {
    statistics();
  }
  if (option ==3)
  {
    showdata();
  }
}

//load data
void loadData()
{
  String[] lines = loadStrings("SteamData.csv");
  for (int i = 0; i <lines.length; i++)
  {
    println(lines);
    Steam steam = new Steam(lines[i]);
    data.add(steam);
    sorted.add(steam);
  }
  for ( int i =0; i < sorted.size (); i++)
  {
    println(sorted.get(i).players);
  }
}

//draw bargraph
void drawBarGraph()
{
  background(255);  
  backtomenu();
  //data store
  float gap = (float) width / data.size();
  float max = Float.MIN_VALUE;
  for (Steam steam : data)
  {
    if (steam.players > max)
    {
      max = steam.players;
    }
  }

  float scaleFactor = (float) height/max;
  for ( int i = 0; i < data.size (); i++)
  {
    Steam steam = data.get(i);
    fill(color(0, 0, 100));
    float x = i * gap;
    rect(x, height, gap, - (steam.players * scaleFactor));
  }

  int index = (int) Math.round((mouseX/gap-0.3));
  if ( index >= 49 )
  {
    index = 49;
  } else
  {
    println(index);
    textAlign(CENTER, CENTER);   
    float border = width * 0.05f;
    float textY = (border * 0.5f  ); 
    fill(color(0, 0, 180));
    rect(width*0.3, 0, width*0.4, 90);
    fill(255);
    textSize(30);
    text(data.get(index).game, width * 0.5f, textY);
    textSize(20);
    text("Highest Peak of Players:" + data.get(index).players, width * 0.5f, border * 1.5f);
    fill(color(0, 0, 255));
    float x = index * gap;
    rect(x-gap*0.25, height, gap+gap*0.5, - (data.get(index).players * scaleFactor));
  }
}

//draw TrendGraphLine
void drawTrendLineGraph(ArrayList<Steam> data, String title)
{
  background(0);
  float border = width * 0.05f;
  // Print the text 
  textAlign(CENTER, CENTER);   
  float textY = (border * 0.5f); 
  text("Steam Graph", width * 0.5f, textY);

  drawAxis(border);   
  float windowRange = (width - (border * 2.0f));
  float dataRange = 1400000;      
  float lineWidth =  windowRange / (float) (data.size() - 1) ;

  stroke(180);
  for (int i = 1; i < data.size (); i ++)
  {
    float x1 = map(i - 1, 0, data.size(), border, border + windowRange);
    float x2 = map(i, 0, data.size(), border, border + windowRange);
    float y1 = map(data.get(i - 1).players, 0, dataRange, height - border, (height - border) - windowRange);
    float y2 = map(data.get(i).players, 0, dataRange, height - border, (height - border) - windowRange);
    ellipse(x1, y1, 5, 5);
    line(x1, y1, x2, y2);
  }

  if (mousePressed)
  {
  }
  float currentX = map(mouseY, height-border, 0, border, 1000000);
  float currentY = map(mouseX, 0, width-border, border, 1000000);
  int index = (int) Math.round(currentX/lineWidth);
  println(currentX);
  println(currentY);
  println(index);
}

// draw axis for trend graph
void drawAxis(float border)
{
  stroke(200, 200, 200);
  fill(200, 200, 200);   
  line(border, height - border, width - border, height - border);
  line(border, border, border, height - border);
}

//added startup
int option = 0;
void drawmenu()
{
  background(255);
  textAlign(CENTER, CENTER);
  //option 1
  fill(color(200, 0, 0));
  rect(width*0.25, height*0.1, width*0.50, 100);
  fill(180);
  textSize(40);
  text("Menu", width * 0.5f, height*0.1+50);
  //option 1
  fill(color(200, 0, 0));
  rect(width*0.25, height*0.3, width*0.50, 100);
  fill(180);
  textSize(40);
  text("Bar Graph", width * 0.5f, height*0.3+50);

  //option 2
  fill(color(200, 0, 0));
  rect(width*0.25, height*0.5, width*0.50, 100);
  fill(180);
  textSize(40);
  text("Statistics", width * 0.5f, height*0.5+50);

  //option 3
  fill(color(200, 0, 0));
  rect(width*0.25, height*0.7, width*0.50, 100);
  fill(180);
  textSize(40);
  text("List of Data", width * 0.5f, height*0.7+50);

  println(mouseY);
  if (mouseX >= width*0.25 && mouseX <= width*0.50 )
  {
    //option 1
    if (mouseY >= height*0.3 && mouseY <= (height*0.3)+100 )
    {
      fill(color(255, 0, 0));
      rect(width*0.225, height*0.275, width*0.55, 130);
      fill(180);
      textSize(50);
      text("Bar Graph", width * 0.5f, height*0.3+50);
      if (mousePressed)
      {
        option = 1;
      }
    }
    //option 2
    if (mouseY >= height*0.5 && mouseY <= (height*0.5)+100 )
    {
      fill(color(255, 0, 0));
      rect(width*0.225, height*0.475, width*0.55, 130);
      fill(180);
      textSize(50);
      text("Statistics", width * 0.5f, height*0.5+50);
      if (mousePressed)
      {
        option = 2;
      }
    }
    //option 3
    if (mouseY >= height*0.7 && mouseY <= (height*0.7)+100 )
    {
      fill(color(255, 0, 0));
      rect(width*0.225, height*0.675, width*0.55, 130);
      fill(180);
      textSize(50);
      text("List of data", width * 0.5f, height*0.7+50);
      if (mousePressed)
      {
        option = 3;
      }
    }
  }
}


//back to menu 
void backtomenu()
{
  textAlign(CENTER, CENTER);
  //exit option
  fill(color(200, 0, 0));
  rect(width*0.9, 0, width*0.1, height*0.075);
  fill(255);
  textSize(20);
  text("menu", width*0.95, width*0.022);
  if (mouseX >= width*0.9 && mouseY <= height*0.075)
  {
    fill(color(255, 0, 0));
    rect(width*0.9, 0, width*0.1, height*0.075);
    fill(255);
    textSize(20);
    text("menu", width*0.95, width*0.022);
    if (mousePressed)
    {
      option = 0;
    }
  }
}

//show statistic option
void statistics()
{
  background(255);

  //makes the nav bar  
  for ( int i = 0; i < 5; i++)
  {
    fill(0);
    rect(i*(width*0.2), 0, width*0.2, height*0.1);
  }
  //label the nav bar
  fill(255);
  textSize(30);
  text("Option 1", width*0.1, height*0.050);
  text("Option 2", width*0.3, height*0.050);
  text("Option 3", width*0.5, height*0.050);
  text("Option 4", width*0.7, height*0.050);
  text("menu", width*0.9, height*0.050);
  //detects nav bar
  if (mouseY <= height*0.1 && mouseX <= width*0.2)
  {
    fill(0);
    rect(0, 0, width*0.2, height*0.15);
    textSize(30);
    fill(255);
    text("Option 1", width*0.1, height*0.075);
  }
  if (mouseY <= height*0.1 && mouseX <= width*0.4 && mouseX >= width*0.2)
  {
    fill(0);
    rect(width*0.2, 0, width*0.2, height*0.15);
    textSize(30);
    fill(255);
    text("Option 2", width*0.3, height*0.075);
  }
  if (mouseY <= height*0.1 && mouseX <= width*0.6 && mouseX >= width*0.4)
  {
    fill(0);
    rect(width*0.4, 0, width*0.2, height*0.15);
    textSize(30);
    fill(255);
    text("Option 3", width*0.5, height*0.075);
  }
  if (mouseY <= height*0.1 && mouseX <= width*0.8 && mouseX >= width*0.6)
  {
    fill(0);
    rect(width*0.6, 0, width*0.2, height*0.15);
    textSize(30);
    fill(255);
    text("Option 4", width*0.7, height*0.075);
  }
  if (mouseY <= height*0.1 && mouseX <= width && mouseX >= width*0.8)
  {
    fill(0);
    rect(width*0.8, 0, width*0.2, height*0.15);
    textSize(30);
    fill(255);
    text("menu", width*0.9, height*0.075);
    if (mousePressed)
    {
      option = 0;
    }
  }
}

//find popular
void popular()
{
  float max = Float.MIN_VALUE;
  for (Steam steam : data)
  {
    if (steam.players > max)
    {
      max = steam.players;
    }
  }
}

//find the least popular
void unpopular()
{
  float lowest = Float.MIN_VALUE;
  for (Steam steam : data)
  {
    if (steam.players < lowest)
    {
      lowest = steam.players;
    }
  }
}

//data list
void datalist()
{
  background(255);
  textAlign(CENTER, CENTER);
  backtomenu();

  float gap = ( height / 10 );
  int page = 0;
  int current = 1;
  if (mousePressed)
  {
    page++;
    for ( int i = current; i < current+9; i++ )
    {
      fill(255);
      rect(0, i*(gap), width*0.5, gap);
      rect(width*0.5, i*(gap), width*0.5, gap);
      fill(0);
      text(data.get(i-1).game, width*0.25, i*gap+25);
      text(data.get(i-1).players, width*0.75, i*gap+25);
    }
  }
  fill(255);
  rect(0, 0, width, gap);
  fill(0);
  text("Game", width*0.25, 25);
  text("Peaked Players", width*0.75, 25);
}

int pageoption = 0;
int checker = 11;
void showdata()
{  
  if ( keyPressed )
  {
    if (key == '1')
    {
      pageoption = 0;
      checker = 11;
    }
    if (key == '2')
    {
      pageoption = 1;
      checker = 11;
    }
    if (key == '3')
    {
      pageoption = 2;
      checker = 11;
    }
    if (key == '4')
    {
      pageoption = 3;
      checker = 11;
    }
    if (key == '5')
    {
      pageoption = 4;
      checker = 11;
    }
    if (key == '6')
    {
      pageoption = 5;
      checker = 5;
    }
  }
  background(255);
  float gap = ( height / 10 );
  int i, j;
  for ( i = 1+ (pageoption*9), j = 0; i < (pageoption*9)+checker; i++, j++)
  {
    fill(255);
    rect(0, j*(gap), width*0.5, gap);
    rect(width*0.5, j*(gap), width*0.5, gap);
    fill(0);
    textSize(20);
    text(data.get(i-1).game, width*0.25, j*gap+25);
    text(data.get(i-1).players, width*0.75, j*gap+25);
  }
  fill(255);
  rect(0, 0, width, gap);
  fill(255);
  rect(0, 0, width*0.5, gap);
  rect(width*0.5, 0, width*0.5, gap);
  fill(0);
  text("Game", width*0.25, 25);
  text("Peaked Players", width*0.75, 25);
  println(pageoption);
  backtomenu();
}

