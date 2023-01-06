class FPlayer extends FBox {
  
  FPlayer() {
   super(gridSize, gridSize);
   setPosition(300, 0);
   setFillColor(red);
  }
  
  void act() {
    float vy = getVelocityY();
  if (akey) setVelocity(-200, vy);
  if (dkey) setVelocity(200, vy);
  
}

}
