class Ball{
  
  Body body;
  float r;
  
  //constructor
  Ball(float x_, float y_, float r_){
    float x = x_;
    float y = y_;
    r = r_;
    
    makeBody(new Vec2(x,y),r);
  }
  
  void killBody(){
    box2d.destroyBody(body);
  }
  
  
  boolean contains(float x, float y){
    Vec2 worldPoint = box2d.coordPixelsToWorld(x,y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }
  
  
  void display(){
    //we look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    //Get its angle of rotations
    float a = body.getAngle();
    
    ellipseMode(CENTER);
    noStroke();
    fill(0);
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    circle(0,0,r*2);
    popMatrix();
  }
  
  
  void makeBody(Vec2 center, float r){
    //Define and create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    //Define a fixture
    FixtureDef fd = new FixtureDef();
    //fd.shape = sd;
    fd.shape = cs;
    
    //Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    body.createFixture(fd);
    
    //give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-5,5),random(2,5)));
    body.setAngularVelocity(random(-5,5));
    
  }
}
