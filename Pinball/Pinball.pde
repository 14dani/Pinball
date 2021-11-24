//hello world
import ddf.minim.*;

Minim minim;
AudioPlayer playI;
AudioPlayer playJ;
AudioSample RisaE;
AudioSample GrapHook;
AudioSample Punch1;
AudioSample Punch2;
AudioSample Punch3;
AudioSample Punch4;
AudioSample Punch5;

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

// A reference to our box2d world
Box2DProcessing box2d;


//Escenarios
Escenario escPortada;
Escenario escJuego;

ArrayList<Boundary> paredes;
ArrayList<Boundary> obstaculos;
ArrayList<Ball> pelotas;



//Superficies organicas
Surface arco, arco1, arcoMedio; //Arcos
Surface salida;
Surface pared, pared1;
Surface paredFlotanteIzq;
Surface paredFlotanteDer;


//Escenario
int escenario;

//Puntos
int puntos = 0;
int vidas = 5;
float Punch;

//Variables para disparo
long keyDown, keyUp; //Momento en que se presiona la tecla, momento en que se suelta
boolean disparando;

// Animaciones
ArrayList<AniObs> Ani;
//for the flippers
Flipper fl;
Flipper fr;
//turning flippers on/off
boolean lflip;
boolean rflip;


//Motor
Motor motor1, motor2, motor3;

PFont fuenteJoker;

void setup(){
  
  size(500, 700);
  smooth();

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  minim = new Minim(this);
  box2d.listenForCollisions(); //monitoreo de colisiones
  
  playI = minim.loadFile("Arab Ambient (Full).mp3");
  playJ = minim.loadFile("War.mp3");
  RisaE = minim.loadSample("Risa-Joker-especial.wav");
  GrapHook = minim.loadSample("GrapHook.wav");
  Punch1 = minim.loadSample("Punch 01.mp3");
  Punch2 = minim.loadSample("Punch 02.mp3");
  Punch3 = minim.loadSample("Punch 03.mp3");
  Punch4 = minim.loadSample("Punch 04.mp3");
  Punch5 = minim.loadSample("Punch 05.mp3");
  
  
  escenario = 1;
  playJ.play();
  playJ.loop();
  
  //Animaciones
  Ani = new ArrayList<AniObs>();
  
  //Escenario
  escPortada = new Escenario(loadImage("Foto-portada.png"));
  escJuego = new Escenario(loadImage("Escena 2.png"));
  
  // flippers
  fr = new Flipper(width/2 + 70, height - 120, 25, -QUARTER_PI/2, QUARTER_PI, false, 15, 10, 60);
  fl = new Flipper(width/2 - 120, height - 120, 25, -QUARTER_PI/2 - radians(15), QUARTER_PI - radians(20), true, 15, 10, 60); //have no idea why they don't match up but this works
  
  //ft = new Flipper(10, 500, 25, -QUARTER_PI, HALF_PI - QUARTER_PI, true, 10,5,30);
  //SuperficieOrgánica
  arco = new Surface(width/2, height/2-95, width/2, 180, 360);
  arco1 = new Surface(width/2, height/2-95, width/2-30, 280, 360);
  arcoMedio = new Surface(width/2, height/2+60, 90, 210, 330 );

  
  //Superficie salida
  ArrayList<Vec2> puntos = new ArrayList <Vec2>();
  puntos.add(new Vec2(496, 403));
  puntos.add(new Vec2(470, 403));
  puntos.add(new Vec2(470, 240));
  salida = new Surface(puntos);
  
  ArrayList<Vec2> puntosP = new ArrayList <Vec2>();
  puntosP.add(new Vec2(width/2, 0));
  puntosP.add(new Vec2(width/2-100, 72));
  pared = new Surface(puntosP);
  
  ArrayList<Vec2> puntosP2 = new ArrayList <Vec2>();
  puntosP2.add(new Vec2(width/2+40, 45));
  puntosP2.add(new Vec2(width/2+40, 72));
  pared1 = new Surface(puntosP2);
  
  
  //Paredes Inferiores Flotantes
  ArrayList<Vec2> puntosIzq = new ArrayList <Vec2>();
  puntosIzq.add(new Vec2(40, 540));
  puntosIzq.add(new Vec2(40, 596));
  puntosIzq.add(new Vec2(134, 638));
  paredFlotanteIzq = new Surface(puntosIzq);
  
  ArrayList<Vec2> puntosDer = new ArrayList <Vec2>();
  puntosDer.add(new Vec2(width-40, 540));
  puntosDer.add(new Vec2(width-40, 596));
  puntosDer.add(new Vec2(width-134, 638));
  paredFlotanteDer = new Surface(puntosDer);

  
  
  //Paredes
  paredes = new ArrayList<Boundary>();
  paredes.add(new Boundary(width/2,height,width,4)); //pared de abajo
  //paredes.add(new Boundary(width/2,5,width,5)); //pared de arriba
  paredes.add(new Boundary(width,height/2+220,4,height));//pared de la izquierda
  paredes.add(new Boundary(0,height/2+220,4,height));//pared de la derecha
  
  
  
  
  //Obstaculos
  obstaculos = new ArrayList<Boundary>();
  
  //Treboles superiores
  Boundary ob1 = new Boundary(width/2-85,149,30,"TRL", 10); //Obstaculo de arriba
  //ob1.caracteristicas("obstaculo", 10);
  obstaculos.add(ob1);
  
  Boundary ob2 = new Boundary(width/2+61,149,30,"TRL", 10); //Obstaculo de arriba
  //ob2.caracteristicas("portal", 10);
  obstaculos.add(ob2);
  
  
  //Corona
  Boundary ob3 = new Boundary(43,180,8,"C", 50); //Obstaculo de arriba
  //ob3.caracteristicas("obstaculoE", 50);
  obstaculos.add(ob3);
  
  
  //Diamantes
  //Boundary ob4 = new Boundary(420,305,14); //Obstaculo de arriba
  //ob4.caracteristicas("obstaculo", 30);
  //obstaculos.add(ob4);
  
  //Boundary ob5 = new Boundary(410,370,14); //Obstaculo de arriba
  //ob5.caracteristicas("obstaculo", 30);
  //obstaculos.add(ob5);
  
  //Boundary ob6 = new Boundary(380,420,14); //Obstaculo de arriba
  //ob6.caracteristicas("obstaculo", 30);
  //obstaculos.add(ob6);
  
  
  //Espadas
  Boundary ob7 = new Boundary(59,384,25,"portal", 40); //Obstaculo de arriba
  //ob7.caracteristicas("portal", 40);
  obstaculos.add(ob7);
  
  Boundary ob8 = new Boundary(118,482,25,"ESP2", 40); //Obstaculo de arriba
  //ob8.caracteristicas("obstaculo", 40);
  obstaculos.add(ob8);
  
  
  //Trebol inferior
  Boundary ob10 = new Boundary(width/2,500, 30,"TRG", 10); //Obstaculo de arriba
  //ob10.caracteristicas("obstaculo", 10);
  obstaculos.add(ob10);
  
  
  //Cuerpos dinámicos
  pelotas = new ArrayList<Ball>();
  
   
  
  
  //Motor
  motor1 = new Motor(425,320);
  motor1.caracteristicas("obstaculo2", 0);
  
  motor2 = new Motor(405,400);
  motor2.caracteristicas("obstaculo2", 0);
  
  motor3 = new Motor(385,480);
  motor3.caracteristicas("obstaculo2", 0);
  
  fuenteJoker = createFont("The Joker.otf", 42);


}


void draw(){
  
  if(escenario == 1){
    escenarioPortada();
    playJ.loop();
    playJ.play();
    
  }
  else{
    escenarioJuego();
    //playJ.restart();
    playJ.play();
    //playJ.loop();
  }
  
  box2d.step(); 
  
 


}


void escenarioPortada(){
  escPortada.display();
}


void escenarioJuego(){
  escJuego.display();
  
  arco.display();
  arco1.display();
  arcoMedio.display();
  salida.display();
  pared.display();
  pared1.display();
 //display flippers
  fr.display();
  fl.display(); 
    rflip = true;
  lflip = true;
  
  for (Boundary pared : paredes) {  //busca las paredes en el arraylist
    pared.display();
  }
  for (Boundary obs : obstaculos) { //busca los obstaculos en el arraylist
    obs.display();
  }
  
  for (Ball plt : pelotas) { //busca los obstaculos en el arraylist
    plt.display();
    if (plt.getActivarPortal())
    {
      plt.portal(width/2+80,180);
    }
    
  }
  
  
  
  //pelota.display();
  fill(255);
  textFont(fuenteJoker);
  text(puntos, 30, 70);
  text(vidas, width-30, 70);
  
  
  
  motor1.display();
  motor2.display();
  motor3.display();
  
  if (pelotas.size() == 5) {
    Ball aux = pelotas.get(pelotas.size()-1);
    if (aux.done()) {
      
      //escenario = 3;
    }
  }

}

 //Metodos reciben la información cuando se hace un contacto
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  Body b3 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  Object m2 = b3.getUserData();

// if de obstaculos normales
  if (o1.getClass() == Ball.class && o2.getClass() == Boundary.class) {
    Boundary tmpOb = (Boundary) o2;
    if (tmpOb.getId().equals("TRL")){
      tmpOb.animar();
      //Ball tmpBall = (Ball) o1; //o1 de tipo ball
      //tmpBall.ganarPuntos(tmpOb.getValor());
      ganarPuntos(tmpOb.getValor());
      Punch2.trigger();
    }
    else if (tmpOb.getId().equals("portal")){
      Ball aux = (Ball) o1;
      aux.teletransportar();
      tmpOb.animar();
    }
     else if (tmpOb.getId().equals("ESP2")){
      tmpOb.animar();
    }
  }
  
  if (o1.getClass() == Boundary.class && o2.getClass() == Ball.class) {
    Boundary tmpOb = (Boundary) o1;
    if (tmpOb.getId().equals("obstaculo")){
      //Ball tmpBall = (Ball) o1; //o1 de tipo ball
      //tmpBall.ganarPuntos(tmpOb.getValor());
      ganarPuntos(tmpOb.getValor());
      //RisaE.trigger();
      Punch2.trigger(); 
    }
    else if(tmpOb.getId().equals("portal")){
      Ball aux = (Ball) o2;
      aux.teletransportar();
      //AniObs(char tipo, PVector _loc);
    }
  }
  
  
  // if de obstaculo especial = risa joker
  if (o1.getClass() == Ball.class && o2.getClass() == Boundary.class) {
    Boundary tmpOb = (Boundary) o2;
    if (tmpOb.getId().equals("HA")){
      //Ball tmpBall = (Ball) o1; //o1 de tipo ball
      //tmpBall.ganarPuntos(tmpOb.getValor());
      ganarPuntos(tmpOb.getValor());
      RisaE.trigger();      
    }
  }
  
  if (o1.getClass() == Boundary.class && o2.getClass() == Ball.class) {
    Boundary tmpOb = (Boundary) o1;
    if (tmpOb.getId().equals("HA")){
      //Ball tmpBall = (Ball) o1; //o1 de tipo ball
      //tmpBall.ganarPuntos(tmpOb.getValor());
      ganarPuntos(tmpOb.getValor());
      RisaE.trigger();
    }
  }
  
  
  // if de obstaculo especial = risa joker
  if (o1.getClass() == Ball.class && m2.getClass() == Motor.class) {
    Motor tmpOb = (Motor) o2;
    if (tmpOb.getId().equals("obstaculo2")){
      //Ball tmpBall = (Ball) o1; //o1 de tipo ball
      //tmpBall.ganarPuntos(tmpOb.getValor());
      Punch2.trigger();      
    }
  }
  
  if (m2.getClass() == Motor.class && o2.getClass() == Ball.class) {
    Motor tmpOb = (Motor) o1;
    if (tmpOb.getId().equals("obstaculo2")){
      //Ball tmpBall = (Ball) o1; //o1 de tipo ball
      //tmpBall.ganarPuntos(tmpOb.getValor());
      Punch2.trigger();
    }
  }

}

// Objects stop touching each other
void endContact(Contact cp) {
}


void ganarPuntos(int pnt){
  puntos+=pnt;
}


void keyPressed(){
  if(key == 's' || key == 'S'){
    escenario = 2;
  }
  else if(key == '1'){
    escenario = 1;
  }
  
  if(key == ' '){
    if(disparando == false){
      keyDown = millis();
      disparando = true;
      
      
    }
  }
  if(keyCode == RIGHT && rflip)
  {
    fr.reverseSpeed();
    //ff.reverseSpeed();
    rflip = false;
   // fflip = false;
  }
  if(keyCode == LEFT && lflip)
  {
    fl.reverseSpeed();
    //ft.reverseSpeed();
    lflip = false;
    //tflip = false;
  }
}


void keyReleased(){
  if(key == ' '){
    if(pelotas.size()<5){
      keyUp = millis();
      long difTiempo = keyUp - keyDown;
      float potencia = map(constrain(difTiempo, 0, 7000), 0, 7000, 50, 150);
      Ball pelota = new Ball(width-15, 389, 10); 
      pelota.potenciaDisparo(potencia);
      pelotas.add(pelota);
      vidas--;
      GrapHook.trigger();
    }
    //Ball nuevaPelota = new Ball(width-15, 389, 10);
    //nuevaPelota.potenciaDisparo(potencia);
    //pelotas.add(nuevaPelota);
    disparando = false;
  }
}
