import fisica.*;
FWorld world;

color white  = #FFFFFF;
color black  = #000000;
color green  = #00FF00;
color red    = #FF0000;
color blue   = #0000FF;
color orange = #F0A000;
color brown =  #996633;

PImage map;
int gridSize = 32;
float zoom = 1.5;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey , dkey, qkey, ekey, spacekey;
FPlayer player;

void setup() {
  size(600, 600);
  Fisica.init(this);
  map = loadImage("pixelmap.png");
  loadWorld(map);
  loadPlayer();

      }
 
  
  void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);  
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      if ( c == black) {  //stone block
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y *gridSize);
        b.setStatic(true);
        b.setFriction(2);
        //b.attachImage(stone);
        world.add(b);
      }
      //if (c == blue) { //iceblock
      //   FBox b = new FBox(gridSize, gridSize);
      //  b.setPosition(x*gridSize, y *gridSize);
      //  b.setStatic(true);
      //  b.setFriction(0);
      //  b.attachImage(ice); //ice = image of ice block
      //  world.add(b);
      //}
    }
  }
  }

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  background(white);
  drawWorld();
  player.act();
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
