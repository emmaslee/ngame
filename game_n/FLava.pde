class FLava extends FGameObject {
  int frame;

  FLava(float x, float y) {
    super();
    setPosition(x, y);
    frame = 0;
    setName("lava");
  }

  void act() {
    animate();
  }

  void animate() {
    if (frame >= lava.length) frame = 0;
    if (frameCount % 5 == 0) {
      attachImage(lava[frame]);
      frame++;
    }
  }
}
