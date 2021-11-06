//hello world

import shiffman.box2d.*;

import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

// A reference to our box2d world
Box2DProcessing box2d;


//Escenarios
Escenario escPortada;
Escenario escJuego;

ArrayList<Boundary> paredes;
ArrayList<Boundary> obstaculos;

Ball pelota;

//forma semicircular de arriba
Surface arco;


//Escenario
int escenario;

void setup(){
  
  size(500, 700);
  smooth();

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  escenario = 1;
  
 //Escenario
 escPortada = new Escenario(loadImage("Portada_Prueba.png"));
 escJuego = new Escenario(loadImage("Juego_Prueba.png"));
  
  //SuperficieOrgánica
  arco = new Surface(width/2, height/2-95, width/2, 180, 360);
  
  //Paredes
  paredes = new ArrayList<Boundary>();
  paredes.add(new Boundary(width/2,height,width,4)); //pared de abajo
  //paredes.add(new Boundary(width/2,5,width,5)); //pared de arriba
  
  paredes.add(new Boundary(width,height/2+220,4,height));//pared de la izquierda
  paredes.add(new Boundary(0,height/2+220,4,height));//pared de la derecha
  
  //Obstaculos
  obstaculos = new ArrayList<Boundary>();
  obstaculos.add(new Boundary(width/2,height/2,10));//Obs de abajo
  obstaculos.add(new Boundary(width/2+200,height/2-80,20));//dos obs de arriba
  obstaculos.add(new Boundary(width/2-200,height/2-80,20));
  obstaculos.add(new Boundary(width/2,height/2-200,25));//obs de arriba
  obstaculos.add(new Boundary(width/2+100,height/2+200,15));//dos obs de abajo
  obstaculos.add(new Boundary(width/2-100,height/2+200,15));
  
  //Cuerpo dinámico
  pelota = new Ball(width/2-10, 50, 10);


}


void draw(){
  
  if(escenario == 1){
    escenarioPortada();
  }
  else{
    escenarioJuego();
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
  
  pelota.display();
  

}

void keyPressed(){
  if(key == 's' || key == 'S'){
    escenario = 2;
  }
  else if(key == '1'){
    escenario = 1;
  }
  
}
