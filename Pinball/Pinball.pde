//hello world
import ddf.minim.*;

Minim minim;
AudioPlayer playI;
AudioPlayer playJ;

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

Ball pelota;

//Superficies organicas
Surface arco; //Arco superior pantalla
Surface salida;
Surface pared;
Surface paredFlotanteIzq;
Surface paredFlotanteDer;


//Escenario
int escenario;

//Puntos
int puntos = 0;

//Variables para disparo
long keyDown, keyUp; //Momento en que se presiona la tecla, momento en que se suelta
boolean disparando;


//Motor
Motor motor1, motor2;


void setup(){
  
  size(500, 700);
  smooth();

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  minim = new Minim(this);
  box2d.listenForCollisions(); //monitoreo de colisiones
  
  playI = minim.loadFile("Arab Ambient (Full).mp3");
  playJ = minim.loadFile("War.mp3");
  
  escenario = 2;
  
  //Escenario
  escPortada = new Escenario(loadImage("Foto-portada.png"));
  escJuego = new Escenario(loadImage("Foto-Juego.png"));
  
  //SuperficieOrgánica
  arco = new Surface(width/2, height/2-95, width/2, 180, 360);
  
  //Superficie salida
  ArrayList<Vec2> puntos = new ArrayList <Vec2>();
  puntos.add(new Vec2(496, 403));
  puntos.add(new Vec2(470, 403));
  puntos.add(new Vec2(470, 260));
  salida = new Surface(puntos);
  
  //ArrayList<Vec2> puntosP = new ArrayList <Vec2>();
  //puntosP.add(new Vec2(width/2, 0));
  //puntosP.add(new Vec2(width/2, 72));
  //pared = new Surface(puntosP);
  
  
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
  Boundary ob1 = new Boundary(width/2-80,180,20); //Obstaculo de arriba
  ob1.caracteristicas("obstaculo", 10);
  obstaculos.add(ob1);
  
  Boundary ob2 = new Boundary(width/2+80,180,20); //Obstaculo de arriba
  ob2.caracteristicas("obstaculo", 10);
  obstaculos.add(ob2);
  
  
  //Corona
  Boundary ob3 = new Boundary(24,166,5); //Obstaculo de arriba
  ob3.caracteristicas("obstaculo", 50);
  obstaculos.add(ob3);
  
  
  //Diamantes
  Boundary ob4 = new Boundary(420,305,14); //Obstaculo de arriba
  ob4.caracteristicas("obstaculo", 30);
  obstaculos.add(ob4);
  
  Boundary ob5 = new Boundary(410,370,14); //Obstaculo de arriba
  ob5.caracteristicas("obstaculo", 30);
  obstaculos.add(ob5);
  
  Boundary ob6 = new Boundary(380,420,14); //Obstaculo de arriba
  ob6.caracteristicas("obstaculo", 30);
  obstaculos.add(ob6);
  
  
  //Espadas
  Boundary ob7 = new Boundary(65,390,10); //Obstaculo de arriba
  ob7.caracteristicas("obstaculo", 40);
  obstaculos.add(ob7);
  
  Boundary ob8 = new Boundary(24,440,10); //Obstaculo de arriba
  ob8.caracteristicas("obstaculo", 40);
  obstaculos.add(ob8);
  
  Boundary ob9 = new Boundary(90,450,10); //Obstaculo de arriba
  ob9.caracteristicas("obstaculo", 40);
  obstaculos.add(ob9);
  
  
  //Trebol inferior
  Boundary ob10 = new Boundary(width/2,480, 20); //Obstaculo de arriba
  ob10.caracteristicas("obstaculo", 10);
  obstaculos.add(ob10);
  
  //Cuerpo dinámico
  pelota = new Ball(width-15, 389, 10);
  
  //Motor
  motor1 = new Motor(150, 330);
  motor2 = new Motor(width-150, 530);


}


void draw(){
  
  if(escenario == 1){
    escenarioPortada();
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
  for (Boundary pared : paredes) {  //busca las paredes en el arraylist
    pared.display();
  }
  for (Boundary obs : obstaculos) { //busca los obstaculos en el arraylist
    obs.display();
  }
  
  //for(int x = 0; x < 6; x++){
  //  Ball pelota = pelotas.get(x);
  //  pelota.display();
    
  //}
  
  pelota.display();
  text("Puntaje: "+puntos, 100, 20);
  motor1.display();
  motor2.display();

}

 //Metodos reciben la información cuando se hace un contacto
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == Ball.class && o2.getClass() == Boundary.class) {
    Boundary tmpOb = (Boundary) o2;
    if (tmpOb.getId().equals("obstaculo")){
      //Ball tmpBall = (Ball) o1; //o1 de tipo ball
      //tmpBall.ganarPuntos(tmpOb.getValor());
      ganarPuntos(tmpOb.getValor());
    }
  }
  
  if (o1.getClass() == Boundary.class && o2.getClass() == Ball.class) {
    Boundary tmpOb = (Boundary) o1;
    if (tmpOb.getId().equals("obstaculo")){
      //Ball tmpBall = (Ball) o1; //o1 de tipo ball
      //tmpBall.ganarPuntos(tmpOb.getValor());
      ganarPuntos(tmpOb.getValor());
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
  
}


void keyReleased(){
  if(key == ' '){
    keyUp = millis();
    long difTiempo = keyUp - keyDown;
    float potencia = map(constrain(difTiempo, 0, 7000), 0, 7000, 50, 150);
    pelota.potenciaDisparo(potencia);
    //Ball nuevaPelota = new Ball(width-15, 389, 10);
    //nuevaPelota.potenciaDisparo(potencia);
    //pelotas.add(nuevaPelota);
    disparando = false;
  }
}
