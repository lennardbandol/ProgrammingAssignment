ArrayList<Steam> data = new ArrayList<Steam>();
void setup()
{
  size( 800, 600 );
  smooth();
  loadData();
}

int which = 0;

//menu
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
    drawTrendLineGraph(data, "title");
  }
  if (option ==3)
  {
    showdata();
  }
}

//loading the data
void loadData()
{
  String[] lines = loadStrings("SteamData.csv");
  for (int i = 0; i <lines.length; i++)
  {
    println(lines);
    Steam steam = new Steam(lines[i]);
    data.add(steam);
  }
}

//added startup
int option = 0;

void drawmenu()
{
  background(255);
  textAlign(CENTER, CENTER);
  //option 1
  fill(color(50));
  rect(width*0.25, height*0.1, width*0.50, 100, 10);
  fill(180);
  textSize(40);
  text("Menu", width * 0.5f, height*0.1+50);
  //option 1
  fill(color(200, 0, 0));
  rect(width*0.25, height*0.3, width*0.50, 100, 10);
  fill(180);
  textSize(40);
  text("Bar Graph", width * 0.5f, height*0.3+50);

  //option 2
  fill(color(200, 0, 0));
  rect(width*0.25, height*0.5, width*0.50, 100, 10);
  fill(180);
  textSize(40);
  text("Trend Graph", width * 0.5f, height*0.5+50);

  //option 3
  fill(color(200, 0, 0));
  rect(width*0.25, height*0.7, width*0.50, 100, 10);
  fill(180);
  textSize(40);
  text("List of Data", width * 0.5f, height*0.7+50);

   //detects the mouse cursor
  println(mouseY);
  if (mouseX >= width*0.25 && mouseX <= width*0.50 )
  {
    //option 1
    if (mouseY >= height*0.3 && mouseY <= (height*0.3)+100 )
    {
      
      fill(color(255, 0, 0));
      rect(width*0.225, height*0.275, width*0.55, 130, 10);
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
      rect(width*0.225, height*0.475, width*0.55, 130, 10);
      fill(180);
      textSize(50);
      text("Trend Graph", width * 0.5f, height*0.5+50);
      if (mousePressed)
      {
        option = 2;
      }
    }
    //option 3
    if (mouseY >= height*0.7 && mouseY <= (height*0.7)+100 )
    {
      fill(color(255, 0, 0));
      rect(width*0.225, height*0.675, width*0.55, 130, 10);
      fill(180);
      textSize(50);
      text("List of data", width * 0.5f, height*0.7+50);
      if (mousePressed)
      {
        option = 3;
        delay(500);
      }
    }
  }
}

//back to menu 
void backtomenu()
{
  textAlign(CENTER, CENTER);
  //exit option
  fill(0);
  rect(width*0.9-10, 7.5, width*0.1, height*0.075, 10);
  fill(255);
  textSize(20);
  text("menu", width*0.95-10, width*0.022+10);
  if (mouseX >= width*0.9-10 && mouseY <= height*0.075+10 && mouseY >= 10 )
  {
    fill(120);
    rect(width*0.9-12.5, 5, width*0.1+5, height*0.075+5, 10);
    fill(255);
    textSize(23);
    text("menu", width*0.95-10, width*0.022+10);
    if (mousePressed)
    {
      option = 0;
    }
  }
}


//draw bargraph
int chosen = 100;

void drawBarGraph()
{
  //finding the highest value in the data
  float max = Float.MIN_VALUE;
  for (Steam steam : data)
  {
    if (steam.players > max)
    {
      max = steam.players;
    }
  }
  background(255); 
  //scale factor 
  float scaleFactor = (float) height/max;
  //data store
  float gap = (float) width / data.size();
  
  for( int i = 0; i < data.size(); i++ )
  {
    stroke(0);
    strokeWeight(1);
    line(0,i*gap,width,i*gap);
    line(i*gap,0,i*gap,height);
  }
   
  backtomenu();
  for ( int i = 0; i < data.size(); i++)
  {
    //bar graph
    float x = i * gap; 
    //prints the data
    Steam steam = data.get(i);
    fill(data.get(i).colour);
    stroke(0);
    rect(x, height, gap, - (steam.players * scaleFactor));
  }

  //finding the currect index for the bar graph
  int index = (int) Math.round((mouseX/gap-0.3));
  int currentindex = index;
  float currentY = map(mouseY, height, 0, height, max);
  float border = width * 0.05f;
  float textY = (border * 0.5f  ); 

  if ( index >= 49 )
  {
    index = 49;
  } else
  {
    if ( currentY <= data.get(index).players )
    {
      //printing out the data 
      println(index);
      textAlign(CENTER, CENTER);   
      fill(data.get(index).colour);
      rect(width*0.3, 50, width*0.4, 90, 10);
      fill(255);
      textSize(30);
      text(data.get(index).game, width * 0.5f, textY + 50);
      textSize(20);
      text("Highest Peak of Players:" + data.get(index).players, width * 0.5f, border * 1.5f + 50);
      fill(data.get(index).colour);
      float x = index * gap;
      rect(x-gap*0.25, height, gap+gap*0.5, - (data.get(index).players * scaleFactor));
      strokeWeight(2);
      stroke(data.get(index).colour);
      line(width*0.5,140,x+gap*0.5,height - data.get(index).players*scaleFactor * 0.5 );
      noStroke();
    }
  }
}

//draw TrendGraphLine
void drawTrendLineGraph(ArrayList<Steam> data, String title)
{
  float border = width * 0.05f; 
  //load background image
  background(255);
  //menu option
  backtomenu();
  
  //displays the header
  textAlign(CENTER, CENTER);   
  float textY = (border * 0.5f); 
  fill(0);
  textSize(30);
  text("Trend Graph", width * 0.5f, textY);
 
  //draws the horizonal/vertical axis
  drawAxis(border);   
  float windowRange = (width - (border * 2.0f));
  float dataRange = 1100000;      
  
  //prints out the graph
  for (int i = 1; i < data.size(); i ++)
  {
    float x1 = map(i - 1, 0, data.size(), border, border + windowRange);
    float x2 = map(i, 0, data.size(), border, border + windowRange);
    float y1 = map(data.get(i - 1).players, 0, dataRange, height - border, (height - border) - windowRange);
    float y2 = map(data.get(i).players, 0, dataRange, height - border, (height - border) - windowRange);
    //draw the lines
    strokeWeight(2);
    stroke(data.get(i).colour);
    line(x1, y1, x2, y2);
     //draw out the ellipse
    fill(data.get(i).colour);
    ellipse(x1, y1, 5, 5);
    if (mouseX >= x1 && mouseX <= x2)
    {
      fill(data.get(i).colour);
      noStroke();
      rect(width*0.25,height*0.075,width*0.5,height*0.2,10);
      fill(255);
      textSize(25);
      text(data.get(i-1).game + "   -   " + data.get(i-1).players , width*0.5, height*0.175);
      fill(data.get(i).colour);
      ellipse(x1, y1, 15, 15);
    }
  }
  noStroke();
}

// draw axis for trend graph
void drawAxis(float border)
{
  stroke(0);
  fill(200, 200, 200);   
  line(border, height - border, width - border, height - border);
  line(border, border, border, height - border);
}


//show statistic option
void statistics()
{
  backtomenu();
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

int pageoption = 0;
int checker = 11;

//showing the data
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
  //loop to display the text
  for ( i = 1+ (pageoption*9), j = 0; i < (pageoption*9)+checker; i++, j++)
  {
    stroke(0);
    fill(data.get(i-1).colour);
    rect(0, j*(gap), width*0.30, gap);
    rect(width*0.30, j*(gap), width*0.30, gap); 
    rect(width*0.60, j*(gap), width*0.40, gap); 
    fill(255);
    //game & players
    textSize(20);
    text(data.get(i-1).game, width*0.15, j*gap+25);
    text(data.get(i-1).players, width*0.45, j*gap+25);
    //links
    textSize(10);
    text(data.get(i-1).link, width*0.80, j*gap+25);
  }

  //header 
  fill(255);
  rect(0, 0, width, gap);
  fill(255);
  rect(0, 0, width*0.30, gap);
  rect(width*0.30, 0, width*0.30, gap);
  fill(0);
  textSize(20);
  text("Game", width*0.15, 25);
  text("Peaked Players", width*0.45, 25);
  text("Link", width*0.80, 25);
  println(pageoption);
  backtomenu();

  int index = (int) Math.round(((mouseY+30)/gap));
  
  if(index <= 1)
  {
    
  }
  else
  {
    //changing the color when it hovers
    fill(255,69,0);
    rect(0, (index-1)*gap, width*0.30, gap);
    rect(width*0.30,(index-1)*gap, width*0.30, gap); 
    rect(width*0.60,(index-1)*gap, width*0.40, gap);
    textSize(20);
    fill(255);
    text(data.get((pageoption*9)+index-1).game, width*0.15, (index-1)*gap+25);
    text(data.get((pageoption*9)+index-1).players, width*0.45, (index-1)*gap+25);
    //links
    textSize(10);
    text(data.get((pageoption*9)+index-1).link, width*0.80, (index-1)*gap+25);
    if(mousePressed)
    {
      link(data.get((pageoption*9)+index-1).link);
    }
  }
}
