void ganaste() {
  background(0);
  PImage ganar = loadImage ("ganar.png");
  image(ganar, 0, 0);
}

void perdiste() {
  background(0);
  PImage perder = loadImage ("perder.png");
  image(perder, 0, 0);
}

void inicio() {
  textSize(30);
  PImage inicio = loadImage ("Inicio.png");
  image(inicio, 0, 0, width, height);
  fill(0);
  text("(Click para continuar)", width/2, height-20);
}
