class FPlayer extends FGameObject {
  
  FPlayer() {
   super();
   setPosition(0, 0);
   setName("Player");
   setRotatable(false);
   setFillColor(red);
  }
  
  void act() {
    handleInput();
    if (isTouching("spike")){
    setPosition(0,0);
    }
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
  
  //void checkForCollisions() {
  //  ArrayList<FContact> contacts = getContacts();
  //  for (int i = 0; i < contacts.size(); i++) {
  //    FContact fc = contacts.get(i);
  //    if (fc.contains("spike")) {
  //      setPosition(0,0);
  //    }
  //  }
  //}
   


}
