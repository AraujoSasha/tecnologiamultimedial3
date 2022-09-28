import fisica.*;
import processing.sound.*;
SoundFile golpe, gana, pierde, ambiente, collect;


FWorld world;
Personaje kid;

ArrayList <Plataforma> plataformas;
int [] numeros = {55, 50, 45, 40, 35, 30 };
int random, time, time2, time3, time4, estado;
color pcolor = #00FFFFFF;

String [] colors = {"Gum-01.png", "Gum-02.png", "Gum-03.png", "Gum-04.png"};
String collectImage = "Key.png";
int skin;
PImage fondo, fondo2, piso, caida, quieto, kidImage;
boolean addChicle, pickKey;

Chicle chicles;

void setup() {
  size(500, 700);
  fondo = loadImage ("fondo1.png");
  fondo2 = loadImage ("fondo2.png");
  caida = loadImage ("Cae-08.png");
  quieto = loadImage ("quieto-08.png");
  kidImage = loadImage ("agarrado-08.png");

  Fisica.init(this);
  world = new FWorld();
  ambiente = new SoundFile(this, "Ambiente.mp3");
  gana = new SoundFile(this, "Victoria.mp3");
  pierde = new SoundFile(this, "Perder.mp3");
  golpe = new SoundFile(this, "Golpe.mp3");
  collect = new SoundFile(this, "Hit.mp3");
  ambiente.loop();
  textAlign(CENTER);
  world.setEdges(color(#EDEDED, 0));
  //chicles = new Chicle(12);

  kid = new Personaje(15, 18);
  kid.inicializar(width/2, height - 112);
  world.add(kid);

  plataformas = new ArrayList <Plataforma> ();
  Plataforma table = new Plataforma(110, 12);

  for (int i = 0; i < 8; i++) {
    Plataforma p = new Plataforma(182, 12);
    p.inicializar(width/2, height - 111 - (i * 40), pcolor);
    world.add(p);
    plataformas.add(p);
  }

  Plataforma p = new Plataforma(width, 30);
  table.inicializar(30, 530, #C66354);
  p.inicializar(width / 2, height - 8, pcolor);

  world.add(p);
  world.add(table);
  plataformas.add(p);
}

void draw() {
  if (estado==0) {
    inicio();
  } else if (estado==1) {

    //Cambia el fondo al agarrar el coleccionable
    if (!pickKey) {
      image(fondo, 0, 0);
    } else {
      image(fondo2, 0, 0);
    }

    kid.actualizar();

    world.step();
    world.draw();
    random = int(random(numeros.length));
    time++;

    if (time==120) {
      time=4; //Reset time
    }
    if (time==50) {
      addChicle2(); //Chicles verdes
    }
    if (time==90) {
      addChicle3(); //Chicles rojos
    }
    if (time<4) {
      addChicle(); //Chicles azules
    }
    if (time<2) {
      collect(); //Llave o coleccionable
    }

    //Pantalla de ganar solo funciona si agarro el coleccionable
    if (pickKey) {
      if (kid.getY()<=250) {
        estado=2;
        gana.play(1, 0.1);
        ambiente.stop();
      }
    }

    if (kid.getY()>=600) {
      estado=3;
      pierde.play(1, 0.1);
      ambiente.stop();
    }
  } else if (estado==2) {
    ganaste();
  } else if (estado==3) {
    perdiste();
  }
}



void contactStarted(FContact contact) {
  FBody _body1 = contact.getBody1();
  FBody _body2 = contact.getBody2();

  if (_body1.getName() == "personaje" && _body2.getName() == "plataforma"  ) {
    kid.canJump = true;
    kid.attachImage(kidImage);
    if (contact.getNormalX() == 0 && kid.getVelocityY() <=0) {
      if (contact.getNormalY() < 0) {
        _body2.setSensor (true);
      } else {
        _body2.setSensor (false);
      }
    }
    if (kid.getX()<140) {
      kid.attachImage(quieto);
    }
  }

  if ((_body1.getName() == "personaje" && _body2.getName() == "chicle")
    || (_body2.getName() == "personaje" && _body1.getName() == "chicle")) {
    golpe.stop();
    golpe.play();
    //_body1.setSensor (true);
    _body1.setVelocity(0, 100);
    //kid.matar(_body1);
  }


  //Personaje se cae a la derecha de las sillas
  if (kid.getX()>=350 ) {
    kid.attachImage(caida);
    kid.canJump = false;
    kid.setSensor(true);
    kid.setVelocity(0, 300);
  }


  //if (kid.getX()<=145 && (kid.getY()>=100&&kid.getY()<=500)) {
  //kid.setVelocity(0, 200);
  //}

  //Chicle pesado colisona con las plataformas
  if (_body1.getName() == "plataforma" && _body2.getName() == "chiclePesado") {
    _body2.setSensor (true);
  }

  //Personaje agarra el coleccionable
  if (_body1.getName() == "personaje" && _body2.getName() == "collect") {
    collect.stop();
    collect.play();
    removed(_body2);
    pickKey = true;
  }

  //Personaje y Chicle pesado colisionan
  if (_body1.getName() == "personaje" && _body2.getName() == "chiclePesado") {
    golpe.stop();
    golpe.play();

    kid.canJump = false;
    _body1.setSensor (true);
    kid.attachImage(caida);
    _body1.setVelocity(0, 500);
  }
}

void addChicle () {
  skin = int(random(colors.length));

  Chicle chicle= new Chicle (random(6, 8));
  for (int i=0; i<8; i++) {
    chicle.inicializar(random(177, 320), height - 3 - (i * numeros[random]), colors[0], 1500, "");
  }

  world.add(chicle);
  time2++;
  if (time2>=random(4, 6)) {
    chicle.despown();
    world.remove(chicle);
    //time2=0;
  }
}

//Chicles verdes
void addChicle2() {
  Chicle chicle= new Chicle (random(15, 18));
  for (int i=0; i<8; i++) {
    chicle.inicializar(random(177, 320), height - 3 - (i * numeros[random]), colors[1], 8000, "");
  }

  world.add(chicle);
  time3++;
  if (time3>=random(6, 10)) {
    chicle.despown();
    world.remove(chicle);
  }
}

//Chicle pesado rojo
void addChicle3() {
  Chicle chicle3=new Chicle (random(25, 28));
  for (int i=0; i<8; i++) {
    chicle3.inicializar(random(177, 320), height - 115 - (i * 40), colors[2], 80000, "chiclePesado");
  }

  world.add(chicle3);
  time4++;
  if (time4>=random(2, 4)) {
    chicle3.despown();
    world.remove(chicle3);
  }
}

//Llave o coleccionable
void collect() {
  Chicle keys= new Chicle (random(20, 25));
  for (int i=0; i<8; i++) {
    keys.inicializar(random(20, 85), height-190, collectImage, 800, "collect");
  }
  world.add(keys);
}

void removed(FBody body1) {
  world.remove(body1);
}

void mousePressed() {
  if (estado==0) {
    estado=1;
  }
}
