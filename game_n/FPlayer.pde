class FPlayer extends FBox {
  
  FPlayer() {
   super(gridSize, gridSize);
   setPosition(300, 0);
   setFillColor(red);
  }
  
  void act() {
    handleInput();
    checkForCollisions();
    
  }
  
  void handleInput() {
    float left_vx = player.getVelocityX();
    float vy = getVelocityY();
  if (akey) setVelocity(-200, vy);
  if (dkey) setVelocity(200, vy);
  if(hitGround()) {
  if (wkey) player.setVelocity(left_vx, -400);
  }
  }
  
  void checkForCollisions() {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains("spike")) {
        setPosition(0,0);
      }
    }
  }
   


}
