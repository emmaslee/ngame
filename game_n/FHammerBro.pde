class FHammerBro extends FGameObject {

int frame = 0;
int moveTimer = 120;
int speed = 50;
int direction = -1;

 FHammerBro(float x, float y) {
    setPosition(x, y);
    setName("hammerbro");
    setRotatable(false);
 }


void act() {
    animate();
 collide();
 move();
}

void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(hammerbro[frame]);
      if (direction == L) attachImage(reverseImage(hammerbro[frame]));
      frame++;
    }
  }
  
  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX()+direction, getY());
    }
    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize) {
      world.remove(this);
      enemies.remove(this);
      player.setVelocity(player.getVelocityX(), -300);
      } else {
        //player.lives--;
        player.setPosition(0,0);
      
      }
    }
  }
  
    void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
