class coleccionable extends FBox {

  coleccionable(float _w, float _h) {
    super(_w, _h);
  }

  void inicializar(float _x, float _y)
  {
    setName("coleccionable");
    setPosition(_x, _y);
    setStatic(true);
    setGrabbable (false);
    setFillColor(color(#C66354));
    setNoStroke();
  }
}
