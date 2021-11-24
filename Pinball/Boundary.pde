class Boundary {

  float x;
  float y;
  float w;
  float h;
  float r;
  
  Body b;
  
  
  SpriteSheet ani;
  String id;
  int valor = 0;
  int type;
  
  
  //Constructor para elementos cuadrados (paredes)
  Boundary(float x_,float y_, float w_, float h_) {
    
    
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    r = 0;
    id = "";

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
  Boundary(float x_,float y_, float r_, String _id, int _valor) {
    x = x_;
    y = y_;
    w = 0;
    h = 0;
    r = r_;
    id = _id;
    valor = _valor;
    
    
    //if (id.equals("TRL")) 
    //   Ani = new SpriteSheet("TRL_", 13, "png");  
       
    //else if(id.equals("TRG"))  
    //   Ani = new SpriteSheet("TRG_", 19, "png");
      //Trebol portal
      
    //else if(id.equals("HA"))  
    //  Ani = new SpriteSheet("HA_", 14, "png");
      //HAHA's
    if (id.equals("ES2")) 
       ani = new SpriteSheet("ES2_", 9, "png");
     else if(id.equals("portal")) 
      ani = new SpriteSheet("ES1_", 9, "png");
    //  //Espadas 1
    
    //else if(id.equals("ES2"))  
    //  Ani = new SpriteSheet("ES2_", 9, "png");
    //  //Espadas 2
    
    ani.noLoop();
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    b.createFixture(cs,1);
    b.setUserData(this);
  }
  
  
  String getId(){
    return id;
  }
  
  void animar() {
    ani.play();
  }
  
  int getValor(){
    return valor;
  }
  

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    
    if (id.isEmpty()) {
      fill(0);
      stroke(0);
      rectMode(CENTER);
      rect(x,y,w,h);
    }
    else {
      imageMode(CENTER);
      ani.display(x,y);
    }
  }

}
