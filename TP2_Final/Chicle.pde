class Chicle extends FCircle {
  boolean spown;
  Chicle(float _d) {
    super(_d);
  }
  void inicializar(float posX, float posY, String image, int density, String rojo) {
    if (rojo.equals("chiclePesado")) {
      setName("chiclePesado");
    } else if (rojo.equals("collect")) {
      setName("collect");
    } else {
      setName("chicle");
    }
    setStatic(false);
    setPosition(posX, posY);
    attachImage(loadImage (image));
    setNoStroke();
    setVelocity(0, 15);
    setDensity(density);
  }
  void actualizar() {
    if (spown) {
      setVelocity(0, 200);
    }
  }
  void despown() {
    spown=false;
  }
}
