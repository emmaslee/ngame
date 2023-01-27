class FThwomp extends FGameObject {



  FThwomp(float x, float y) {
    super(64, 64);
    setPosition(x+gridSize/2, y+gridSize/2);
    setName("thwomp");
    setRotatable(false);
    setStatic(true);
    attachImage(thwompSleepy);
  }



  void act() {
    if (player.getX() >= this.getX() - 10 && player.getX() <= this.getX() + 10) {
      setStatic(false);
    }
    collide();
  }


  void collide() {
    if (isTouching("player")) {
      lives--;
      player.setPosition(0, 0);
    }
  }
}
