void play() {
  background(black);
  drawWorld();
  actWorld();
  player.act();
  
  textSize(30);
  fill(white);
  text(lives, 130, 40);
  text("lives:", 70, 40);
}
