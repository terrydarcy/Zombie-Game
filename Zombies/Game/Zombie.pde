class Zombie extends Entity {

  float xa= 0, ya;
  boolean roaming = true;
  int health = 100;
  boolean stopped = true;
  float dx= 0, dy =0, dt = 0.3;
  int sight = (int)random(100, 300);
  Sprite sprite;
  int anim =0;
  int dir =0;
  //to stop jittering
  boolean stopY = false, stopX = false;
  boolean flash = false;
  int flashTime = 0;
  int startT = 1;


  Zombie(int x, int y, int w, int h) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    cBoxW = (32/2)-2;
    cBoxH = 20;
    speed = random(0.05, 1);
    sprite = Sprite.zombie_down0;
  }

  @Override
    void tick() {
    if (playerAlive && dist(x, y, level.players.get(0).x, level.players.get(0).y) < sight) {
      roaming = false;
    } else {
      roaming = true;
    }
    int waitTime = (int)random(50, 500);

    if (roaming) {
      if (random(waitTime) < waitTime/3) {
        if ((int)random(waitTime) == 0) {
          dir = 2;
          xa = speed;
        } else if ((int)random(waitTime) == 1) {
          dir = 0;
          xa = -speed;
        }
        if ((int)random(waitTime) == 0) {
          dir = 3;
          ya = speed;
        } else if ((int)random(waitTime) == 1) {
          dir = 1;
          ya = -speed;
        }
      } else  if (random(waitTime) > waitTime/3+waitTime/3) {
        if ((int)random(waitTime) == 0) {
          dir = 2;
          xa = speed;
        } else if ((int)random(waitTime) == 1) {
          dir = 0;
          xa = -speed;
        }
      } else {
        if ((int)random(waitTime) == 0) {
          dir =3;
          ya = speed;
        } else if ((int)random(waitTime) == 1) {
          dir = 1;
          ya = -speed;
        }
      }
    } else {
      if (random(100) >50) {
        if (playerAlive) {
          if (!stopX && x <= (level.players.get(0).x-10)) {
            dir = 2;
            xa = speed;
          } else if (!stopX && x> (level.players.get(0).x+10)) {
            dir = 0;
            xa = -speed;
          } else if (x >= level.players.get(0).x-10 && x <= level.players.get(0).x+10) {
            xa=0;
            dx= 0;
            anim= 0;
            stopX = true;
          } else {
            stopX = false;
          }

          if (!stopY&&y <= level.players.get(0).y-10) {
            dir = 3;
            ya = speed;
          } else if (!stopY&&y > (level.players.get(0).y+10)) {
            dir = 1;
            ya = -speed;
          } else if (y >= level.players.get(0).y-10 && y <= level.players.get(0).y+10) {
            ya=0;
            dy= 0;
            stopY = true;
          } else {
            stopY = false;
          }
        }
      }
    }

    if (playerAlive&& projectileCollision(xa, ya, this)) {
      hurt((int)level.players.get(0).x, (int)level.players.get(0).x, (int)random(20, 60));
    }

    if (flashTime>0) {
      flashTime--;
      flash = true;
    } else {
      flash = false;
    }

    ArrayList<Player> players = level.getPlayers(x, y, 10, this);
    ;

    if (dir== 0) players= level.getPlayers(x-16, y, 10, this);
    if (dir== 1) players= level.getPlayers(x, y-16, 15, this);
    if (dir== 2) players= level.getPlayers(x+16, y, 10, this);
    if (dir== 3) players= level.getPlayers(x, y+16, 15, this);

    for (int i= 0; i<players.size(); i++) {
      players.get(i).hurt((int)x, (int)y, 1);
    }
   
//\    if (startT>0 && collision(x-16, y-16, this)) toRemove = true;
// if(startT>0) startT--;
    
    move(xa, ya);
  }

  void move(float xa, float ya) {
    stopped = false;
    if (anim<Integer.MAX_VALUE) {
      anim++;
    } else {
      anim= 0;
    }    
    if (xa>0 && dx <xa) {
      dx += dt;
    } else if (xa<0 && dx >= xa) dx -= dt;  
    if (ya>0 && dy <= ya) {
      dy += dt;
    } else if (ya<0 && dy > ya) dy -= dt;
    if (!collision(dx, 0, this)) x += dx;
    if (!collision(0, dy, this)) y += dy;
  }

  void hurt(int xp, int yp, int amount) {
    if (xp>x) knockBack(2, 0, this);
    if (xp<x) knockBack(-2, 0, this);
    if (yp>y) knockBack(0, 2, this);
    if (yp<y) knockBack(0, -2, this);
    level.entities.add(new ParticleSpawner(x-16, y-16, 3, 10000, TYPE.BLOOD));
    health-= amount;
    flashTime = 8;
    if (health <= 0) {
      level.entities.add(new ParticleSpawner(x-16, y-16, (int)random(10, 20), 10000, TYPE.BLOOD));
      level.entities.add(new ParticleSpawner(x-16, y-16, 1, 1000000, TYPE.ZOMBIE));
      //level.stamps.add(new Stamp(x-16, y-16, Sprite.zombie_dead));
      toRemove = true;
    }
  }

  void knockBack(float xp, float yp, Entity e) {
    if (!collision((int)x, (int)y, e)) {
      x-=0;
      y-=0;
    }
  }

  @Override
    void render(Render render) {
    if (dir==1) {
      if (anim%20<=10) {
        sprite = Sprite.zombie_up1;
      } else {
        sprite = Sprite.zombie_up2;
      }
    } else  if (dir==3) {
      if (anim%20<=10) {
        sprite = Sprite.zombie_down1;
      } else {
        sprite = Sprite.zombie_down2;
      }
    }

    if (dir==0) {
      if (anim%20<=10) {
        sprite = Sprite.zombie_left1;
      } else {
        sprite = Sprite.zombie_left2;
      }
    } else if (dir==2) {
      if (anim%20<=10) {
        sprite = Sprite.zombie_right1;
      } else {
        sprite = Sprite.zombie_right2;
      }
    }
    //if (!collision(xa, ya, this))    render.renderSprite((int)x- 16, (int)y - 16, sprite, true);
    //else 
    render.renderSprite((int)x- 16, (int)y - 16, sprite, flash);
    //textSize(15);
    //fill(255, 255, 255);
    //String hp = Integer.toString(health);
    //if (playerAlive && dist(x, y, level.players.get(0).x, level.players.get(0).y)<200) text(hp, (int)x-10-hp.length(), (int)y-17);
  }
}