class FPlayer extends FGameObject {
  
  int frame;
  int direction;
 
  
  FPlayer() {
   super();
   frame = 0;
   direction = R;
   setPosition(0, 0);
   setName("player");
   setRotatable(false);
   setFillColor(red);
  }
  
  void act() {
    handleInput();
    if (isTouching("spike")){
      lives--;
    setPosition(0,0);
    }
    if (isTouching("lava")){
      lives--;
    setPosition(0,0);
    }
    animate();
  }
  
  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }
  
  void handleInput() {
    float left_vx = player.getVelocityX();
    float vy = getVelocityY();
     if (abs(vy) < 0.1) {
    action = idle;
  }
  if (akey){
    setVelocity(-200, vy);
    action = run;
    direction = L;
  }
  if (dkey){
    setVelocity(200, vy);
    action = run;
    direction = R;
  }
  if(hitGround()) {
  if (wkey){
    player.setVelocity(left_vx, -400);
  }
  }
  if (abs(vy) > 0.1)
  action = jump;
  
 
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
