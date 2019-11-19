import java.awt.image.*;
int WIDTH= 800, HEIGHT = 800;
int sw = 400, sh = 400;
Level level;
Render render;
static PImage spriteSheet;
PImage cursor;
boolean playerAlive = true;


//BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
//PImage img = new PImage(image.getWidth(), image.getHeight(), PConstants.RGB);
//int[] PIXELS = ((DataBufferInt)image.getRaster().getDataBuffer()).getData();

void setup() {
  size(800, 800);
  colorMode(HSB);
  loadPixels();

  render = new Render(WIDTH, HEIGHT, pixels);

  spriteSheet = loadImage("res/sheets/spritesheet.png");
  cursor = loadImage("res/sheets/cursor.png");
  level = new Level("res/levels/level4.csv");
}

void tick() {
  updatePixels();
  level.tick();
  //println((int)frameRate);
}

float xs;
float ys;
float dist;
int xScroll =0, yScroll = 0;
void draw() {  
  tick();
  render.clear();
  if (playerAlive) {
    xScroll = (int)level.players.get(0).x- WIDTH/2;
    yScroll = (int)level.players.get(0).y- HEIGHT/2;
  }

  level.render(render, xScroll, yScroll);

  String dead = "DEAD";
  textSize(100);
  if (!playerAlive) text(dead, width/2-(dead.length()*35), height/2);
}

//void mouseMoved() {
//    cursor(cursor);
//}

boolean up, down, left, right, shift, addZombies;

void keyPressed() {
  if (key == 'W' || key == 'w') up = true;
  if (key == 'A' || key == 'a') left = true;
  if (key == 'S' || key == 's') down = true;
  if (key == 'D' || key == 'd') right = true;
  if (keyCode == SHIFT ) shift = true;
  if (key == 'z') addZombies = true;
}
void keyReleased() {
  if (key == 'W' || key == 'w') up = false;
  if (key == 'A' || key == 'a') left = false;
  if (key == 'S' || key == 's') down = false;
  if (key == 'D' || key == 'd') right = false;
  if (keyCode == SHIFT ) shift = false;
  if (key == 'z') addZombies = false;
}