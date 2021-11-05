//hello world

import shiffman.box2d.*;

import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

// A reference to our box2d world
Box2DProcessing box2d;

ArrayList<Boundary> paredes;
ArrayList<Boundary> obstaculos;

void setup(){
  
  size(500, 700);
  smooth();

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  paredes = new ArrayList<Boundary>();
  
  paredes.add(new Boundary(width/2,height-5,width,10)); //pared de arriba
  paredes.add(new Boundary(width/2,5,width,10)); //pared de abajo
  paredes.add(new Boundary(width-5,height/2,10,height));//pared de la izquierda
  paredes.add(new Boundary(5,height/2,10,height));//pared de la derecha
  
  obstaculos = new ArrayList<Boundary>();
  obstaculos.add(new Boundary(width/2,height/2,10));


}


void draw(){
  
  background(200);
  box2d.step(); 
  
  for (Boundary pared : paredes) {  //busca las paredes en el arraylist
    pared.display();
  }
  
  for (Boundary obs : obstaculos) {
    obs.display();
  }


}
