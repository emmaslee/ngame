void gameover() {
  background(black);
  sadMario.show();
  textSize(60);
  fill(red);
  text("YOU LOSE", 300, 300);
  restart.show();
  if (restart.clicked) {
    mode = INTRO;
     setup();
  }
 
}
