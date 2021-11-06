//creates the outside of the levels
class Surface
{

 ArrayList<Vec2> points;


    Surface()
    {
    points = new ArrayList<Vec2>();
    
    float theta = 0;
    float count = 5;
    
    //points.add(new Vec2((width/2) + 50, height+20));
    //points.add(new Vec2(width - 50, height - 100));
    //points.add(new Vec2(width-50, height - 500));
    //points.add(new Vec2(width - 50, height));
    //points.add(new Vec2(width-2,height));
    //points.add(new Vec2(width-2, height - 600));
    
    //creates the arch
    while (radians(theta) > (-PI))
    {
      points.add(new Vec2(width/2+(width/2)*cos(radians(theta)),200+200*sin(radians(theta))));
      theta -= count;
    }
    
    points.add(new Vec2(0, height));
    points.add(new Vec2(width/2 - 100, height));
    points.add(new Vec2(0, height - 100));
    
    ChainShape c = new ChainShape();
    
    Vec2[] v = new Vec2[points.size()];
    for(int i=0;i < v.length; ++i)
    {
      v[i] = box2d.coordPixelsToWorld(points.get(i));
    }
    
    c.createChain(v,v.length);
    
    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    body.createFixture(c, 1);
  }
  
  void display() {
    strokeWeight(2);
    stroke(0);
    noFill();
    beginShape();
    for (Vec2 v: points) {
      vertex(v.x,v.y);
    }
    endShape();
  }
}
