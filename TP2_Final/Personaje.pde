class Personaje extends FBox
{
  Boolean leftPressed, rightPressed, upPressed;
  Boolean canJump;
  Boolean vivo;
  int vidas = 8;
  Personaje(float _w, float _h)
  {
    super(_w, _h);
  }

  void inicializar(float posX, float posY) {
    leftPressed = false;
    rightPressed = false;
    upPressed = false;
    canJump = false;
    vivo = true;
    setNoStroke();
    setFill(#181818);
    setName("personaje");
    setPosition(posX, posY);
    setDamping(0);
    setRestitution(0);
    setFriction(0);
    setRotatable(false);
  }

  void actualizar() {
    if (leftPressed) {
      setVelocity(-90, getVelocityY());
    }
    if (rightPressed) {
      setVelocity(90, getVelocityY());
    }
    if (!leftPressed && !rightPressed) {
      setVelocity(0, getVelocityY());
    }

    if (upPressed && canJump) {
      //Salto de la plataforma hacia las sillas
      if (getX()<=150) {
        setVelocity(getVelocityX(), -120);
        canJump = false;
      } else { //Salto entre sillas
        setVelocity(getVelocityX(), -170);
        canJump = false;
      }
    }
  }

  void matar(FBody body1) {

    body1.setSensor (false);
    //Descomentar para agregar vidas al personaje
    //vidas --;
    if (vidas==0) {
      removed(kid);
    }
  }
}

void keyPressed() {
  if (key == 'a') {
    kid.leftPressed = true;
  }
  if (key == 'd') {
    kid.rightPressed = true;
  }
  if (key == 'w') {
    kid.upPressed = true;
  }
}

void keyReleased() {
  if (key == 'a') {
    kid.leftPressed = false;
  }
  if (key == 'd') {
    kid.rightPressed = false;
  }
  if (key == 'w') {
    kid.upPressed = false;
  }


  if (keyCode=='R' || keyCode=='r') {
    setup();
    pickKey = false;
    estado=0;
    time=0;
    time2=0;
    time3=0;
    time4=0;
  }
}
