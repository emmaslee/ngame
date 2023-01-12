import fisica.*;
FWorld world;

color white          = #FFFFFF;
color black          = #000000;
color cyan           = #00FFFF;
color middleGreen    = #00FF00;
color leftGreen      = #009F00;
color rightGreen     = #006F00;
color green          = #004F00;
color red            = #FF0000;  
color purple         = #9000FF;
color blue           = #0000FF;
color orange         = #F0A000;
color brown          = #996633;
color treeTrunkBrown = #FF9500;

PImage map, mapp, mappp, spike, ice, stone, treeTrunk, treeIntersect, treeMiddle, treeEndWest, treeEndEast;
int gridSize = 32;
float zoom = 2;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey , dkey, qkey, ekey, spacekey;
FPlayer player;

void setup() {
  size(600, 600);
  Fisica.init(this);
  loadImages();
  loadWorld(mappp);
  loadPlayer();

      }
 
 void loadImages() {
    map = loadImage("pixelmap.png");
    mapp = loadImage("mapwicetree.png");
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
 }
  
  void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
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
      }
     else if (c == cyan) { //iceblock
        b.setFriction(0);
        b.attachImage(ice); 
        b.setName("ice");
        world.add(b);
      }
     else if (c == treeTrunkBrown) {
        b.attachImage(treeTrunk);
        b.setSensor(true);  //setSensor turns block into ghost, u can pass thru it
        b.setName("tree trunk");
        world.add(b);
      }
     else if (c == middleGreen && s == treeTrunkBrown) { //intersection
      b.attachImage(treeIntersect);
      b.setName("treetop");
      world.add(b);
      }
     else if (c == middleGreen && w == middleGreen & e == middleGreen) { //mid piece
      b.attachImage(treeMiddle);
      b.setName("treetop");
      world.add(b);
      }
      else if (c == middleGreen && w != middleGreen) { //west endcap
      b.attachImage(treeEndWest);
      b.setName("treetop");
      world.add(b);
      }
      else if (c == middleGreen && e != middleGreen) { //east endcap
      b.attachImage(treeEndEast);
      b.setName("treetop");
      world.add(b);
    }
    else if (c == purple) {
      b.attachImage(spike);
      b.setName("spike");
      world.add(b);
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
