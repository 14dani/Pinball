class AniObs {
  
  SpriteSheet ani;
  PVector loc;
  boolean active;
  
  public AniObs(char tipo, PVector _loc) {
    
    if(tipo == '1') {
      ani = new SpriteSheet("TRL_", 13, "png");
      //Trebol de luz
    }
    else if(tipo == '2') {
      ani = new SpriteSheet("TRG_", 19, "png");
      //Trebol portal
      
    }
     else if(tipo == '3') {
      ani = new SpriteSheet("HA_", 16, "png");
      //HAHA's
    }
    else if(tipo == '4') {
      ani = new SpriteSheet("ES1_", 9, "png");
      //Espadas 1
    }
    else if(tipo == '5') {
      ani = new SpriteSheet("ES2_", 9, "png");
      //Espadas 2
    }
  
    loc = _loc;
    active = true;
    ani.noLoop();
    ani.play();
  }
  
  void dibujar() {
    pushMatrix();
    imageMode(CENTER);
    ani.display(loc.x, loc.y);
    if (ani.isFinished())
      active = false;
    popMatrix();
  }
  
  boolean isActive() {
    return active;
  }
}
