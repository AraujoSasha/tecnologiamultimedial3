class Plataforma extends FBox {

  Plataforma(float _w, float _h) {
    super(_w, _h);
  }

  void inicializar(float _x, float _y, color pcolor)
  {
    setName("plataforma");
    setPosition(_x, _y);
    setStatic(true);
    setGrabbable (false);
    setFillColor(color (pcolor));
    setNoStroke();
  }
}
