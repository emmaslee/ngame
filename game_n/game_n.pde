import fisica.*;
FWorld world;

final int INTRO     = 0;
final int PLAY      = 1;
final int GAMEOVER  = 2;
int mode;

PFont rabotnik;

color white          = #FFFFFF;
color black          = #000000;
color gray           = #585858;
color cyan           = #00FFFF;
color middleGreen    = #00FF00;
color leftGreen      = #009F00;
color rightGreen     = #006F00;
color green          = #004F00;
color red            = #FF0000;
color orangered      = #FF5500;
color yellow         = #FFF200;
color purple         = #9000FF;
color pink           = #FF03F3;
color blue           = #0000FF;
color orange         = #F0A000;
color brown          = #996633;
color treeTrunkBrown = #FF9500;
color tgreen         = #1F9740;
color lime           = #CBFF00;
color silver         = #b5b7ec;

Button start;
Button restart;

boolean mouseReleased;
boolean wasPressed;

//terrain
PImage map, mappp, mapy, bridge, spike, ice, stone, treeTrunk, treeIntersect, treeMiddle, treeEndWest, treeEndEast, trampoline, hammer, thwompSleepy;
//lava animations
PImage[] lava;
//character animations
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
//goomba animations
PImage[] goomba;
//thwomp animations
PImage[] thwomp;
//hammerbro animations
PImage[] hammerbro;
int numberOfFrames;

int gridSize = 32;
float zoom = 2;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, dkey, qkey, ekey, spacekey;

//objects and lists of objects
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
FPlayer player;

int lives;
Gif introAnimation;
Gif sadMario;

void setup() {
  size(600, 600);
  lives = 3;
  Fisica.init(this);
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
   introAnimation = new Gif("frame_", "_delay-0.1s.gif", 4, 5, 0, 0, width, height);
   sadMario = new Gif("frame_", "_delay-0.6s.gif", 2, 5, 0, 0, width, height);
  loadImages();
  loadWorld(mapy);
  loadPlayer();
  mode = INTRO;
   makeButtons();
}

void loadImages() {
  map = loadImage("pixelmap.png");
  mapy = loadImage("mapy.png");
  mappp = loadImage("mappp.png");
  ice = loadImage("ice.png");
  treeTrunk = loadImage("tree_trunk.png");
  ice.resize(32, 32);
  stone = loadImage("stone.png");
  treeIntersect = loadImage("tree_intersect.png");
  treeMiddle = loadImage("treetop_center.png");
  treeEndWest = loadImage("treetop_w.png");
  treeEndEast = loadImage("treetop_e.png");
  spike = loadImage("spike.png");
  bridge = loadImage("bridge_center.png");
  trampoline = loadImage("trampoline.png");
  hammer = loadImage("hammer.png");
  thwompSleepy = loadImage("thwomp0.png");


  //load lava
  lava = new PImage[6];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5] = loadImage("lava5.png");

  //load actions
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");

  action = idle;

  //enemies
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0] .resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1] .resize(gridSize, gridSize);
  
  //thwomp animations
  thwomp = new PImage[2];
  thwomp[0] = loadImage("thwomp0.png");
  thwomp[1] = loadImage("thwomp1.png");
  
  //hammerbro animations
  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("hammerbro0.png");
  hammerbro[1] = loadImage("hammerbro1.png");
  
}

void loadWorld(PImage img) {
  world = new FWorld(-1000, -2000, 3000, 2000);
  world.setGravity(0, 900);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {

      color c = img.get(x, y); //color of current pixel
      color s = img.get(x, y+1); //color below current pixel
      color w = img.get(x-1, y); //color west of current pixel
      color e = img.get(x+1, y); //color east of current pixel

      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y *gridSize);
      b.setStatic(true);
      if ( c == black) {  //stone block
        b.attachImage(stone);
        b.setFriction(4);
        b.setName("stone");
        world.add(b);
      } else if (c == gray) {
        //println("wall");
        b.attachImage(stone);
        b.setName("wall");
        world.add(b);
      } else if (c == cyan) { //iceblock
        b.setFriction(0);
        b.attachImage(ice);
        b.setName("ice");
        world.add(b);
      } else if (c == treeTrunkBrown) {
        b.attachImage(treeTrunk);
        b.setSensor(true);  //setSensor turns block into ghost, u can pass thru it
        b.setName("tree trunk");
        world.add(b);
      } else if (c == middleGreen && s == treeTrunkBrown) { //intersection
        b.attachImage(treeIntersect);
        b.setName("treetop");
        world.add(b);
      } else if (c == middleGreen && w == middleGreen & e == middleGreen) { //mid piece
        b.attachImage(treeMiddle);
        b.setName("treetop");
        world.add(b);
      } else if (c == middleGreen && w != middleGreen) { //west endcap
        b.attachImage(treeEndWest);
        b.setName("treetop");
        world.add(b);
      } else if (c == middleGreen && e != middleGreen) { //east endcap
        b.attachImage(treeEndEast);
        b.setName("treetop");
        world.add(b);
      } else if (c == purple) {
        b.attachImage(spike);
        b.setName("spike");
        world.add(b);
      } else if (c == tgreen) {
        b.attachImage(trampoline);
        b.setVelocity(x, -800);
        b.setName("trampoline");
        world.add(b);
      } else if (c == pink) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      } else if (c == orangered) {
        FLava la = new FLava(x*gridSize, y*gridSize);
        terrain.add(la);
        world.add(la);
      } else if (c == yellow) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c == lime) {
        FHammerBro hmb = new FHammerBro(x*gridSize, y*gridSize);
        enemies.add(hmb);
        world.add(hmb);
      } else if (c == silver) {
        FThwomp tmp = new FThwomp(x*gridSize, y*gridSize);
        enemies.add(tmp);
        world.add(tmp);
      }
    }
  }
  
  }


void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  background(white);
  click();
   introAnimation.show();
  
  if (mode == INTRO) {
    intro();
  } else if (mode == PLAY) {
    play();
  } else if (mode == GAMEOVER) {
    gameover();
  }
  
  if (lives == 0) {
    mode = GAMEOVER;
  }
  //drawWorld();
  //actWorld();
  //player.act();
}

void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void makeButtons() {
  rectMode(CENTER);
  start = new Button("START", 130, 500, 150, 100, white, black);
  restart = new Button("HOME", 300, 450, 150, 100, red, blue);
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
