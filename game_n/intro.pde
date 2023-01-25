void intro() {
  //background(white);
  rabotnik = createFont("Rabotnik.ttf", 70);
textSize(72);
  textFont(rabotnik);
  
   introAnimation.show();
   text("SUPER MARIO", 300, 200);
   start.show();
  if (start.clicked) {
    mode = PLAY;
  }
   }
