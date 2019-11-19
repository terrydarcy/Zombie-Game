class Crate extends Entity {

  int health = 100;
  int flashTime = 0;
  boolean flash = false;

  Crate(float x, float y) {
    this.x=x;
    this.y=y;
    cBoxW = 35;
    cBoxH =25;
  }
  int xa=0, ya = 0;

  void tick() {
    xa=ya=0;
    ArrayList<Player> playersLeft = level.getPlayers(x, y+16, 20, this);
    ArrayList<Player> playersRight = level.getPlayers(x+35, y+16, 20, this);
    ArrayList<Player> playersTop = level.getPlayers(x+16, y, 20, this);
    ArrayList<Player> playersDown = level.getPlayers(x+16, y+35, 20, this);
    //if(playersLeft.size()>0) xa++;
    //else if(playersRight.size()>0) xa--;

    //if(playersTop.size()>0) ya++;
    //else if(playersDown.size()>0) ya--;
    float speed = 1;
    if (crateCollision(-3, 0)) xa-=speed;
    if (crateCollision(3, 0)) xa+=speed;
    if (crateCollision(0, -3)) ya-=speed;
    if (crateCollision(0, 3)) ya+=speed;

    // println(playersLeft.size(), playersRight.size(),playersTop.size(),playersDown.size());
    if (!tileCollision(xa, 0, this)) x+=xa;
    if (!tileCollision(0, ya, this)) y+=ya;

    if (flashTime>0) {
      flashTime--;
      flash = true;
    } else {
      flash = false;
    }

    if (playerAlive&& projectileCollision(xa, ya, this)) {
      hurt(0, 0, (int)random(20, 40));
    }
  }

  void hurt(int xp, int yp, int amount) {
    health-= amount;
    level.entities.add(new ParticleSpawner(x+16, y+16, 10, 1000000, TYPE.CRATE));
    flashTime = 8;
    if (health <= 0) {
      level.entities.add(new ParticleSpawner(x+16, y+16, 10, 1000000, TYPE.CRATE));
      toRemove = true;
    }
  }

  void render(Render render) {

    render.renderSprite((int)x, (int)y, Sprite.crate, flash);
  }
}