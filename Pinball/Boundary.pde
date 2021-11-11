class Boundary {

  float x;
  float y;
  float w;
  float h;
  float r;
  
  Body b;
  
  String id = "";
  int valor = 0;
  
  
  //Constructor para elementos cuadrados (paredes)
  Boundary(float x_,float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    r = 0;

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
    b.setUserData(this);
  }
  
  //Constructor para elementos circulares (obstaculos)
  Boundary(float x_,float y_, float r_) {
    x = x_;
    y = y_;
    w = 0;
    h = 0;
    r = r_;
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    b.createFixture(cs,1);
    b.setUserData(this);
  }
  
  
  void caracteristicas(String _id, int _valor){
    id = _id;
    valor = _valor;
  }
  
  
  String getId(){
    return id;
  }
  
  
  int getValor(){
    return valor;
  }
  

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    fill(0);
    stroke(0);
    if (r == 0) {
      rectMode(CENTER);
      rect(x,y,w,h);
    }
    else {
      ellipseMode(CENTER);
      circle(x,y,r*2);
    }
  }

}
