
class Player extends Entity {

  Sprite sprite;
  int speed = 2;
  int time;
  boolean firstShot= true;
  boolean stopped = true;
  float dx= 0, dy =0, dt = 0.3;
  boolean pistol = true;
  boolean grenade = true;
  int grenadePrime =50;
  int anim = 0;
  int health = 100;
  boolean alive = true;
  boolean flash = false;
  int flashTime = 0;

  Player(int x, int y, int w, int h) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.y=y;
    cBoxW = (32/2);
    cBoxH = 20;
    sprite = Sprite.player_down0;
  }

  void tick() {
    time++;


    if (mousePressed && (mouseButton == LEFT)) {
      if (pistol)shoot(20);
    } else {
      firstShot = true;
    }

    if (mousePressed && (mouseButton == RIGHT)) {
      if (grenade&& grenadePrime<500) {
        grenadePrime+=3;
      } else if (grenade) {
        throwGrenade(grenadePrime);
        grenadePrime = 50;
      }
    } else {
      if (grenadePrime>50) {
        throwGrenade(grenadePrime);
        grenadePrime = 50;
      }
    }
    int xa=0, ya=0;
    if ( shift) {
      speed = 2;
    } else {
      speed =1;
    }
    if (up) ya= -speed;
    if (down) ya = speed;
    if (left) xa =-speed;
    if (right) xa = speed;

    if (xa==0) {
      if (dx>0) {
        if (dx<dt)dx =0;
        dx -= dt;
      }
      if (dx<0) {
        dx += dt;
      }
    }
    if (ya==0) {
      if (dy>0) {
        dy -= dt;
        if (dy<dt)dy =0;
      }
      if (dy<0) {
        dy += dt;
      }
    } 

    if (flashTime>0) {
      flashTime--;
      flash = true;
    } else {
      flash = false;
    }

    move(xa, ya);
  }

  void move(int xa, int ya) {
    if (anim<Integer.MAX_VALUE) {
      anim++;
    } else {
      anim= 0;
    }
    stopped = false;
    if (xa>0 && dx < xa) dx += dt;
    if (xa<0 && dx > xa) dx -= dt;
    if (ya>0 && dy < ya) dy += dt;
    if (ya<0 && dy > ya) dy -= dt;
    if (!collision(dx, 0, this)) x += dx;
    if (!collision(0, dy, this)) y += dy;
  }

  void hurt(int xp, int yp, int amount) {
    health-= amount;
    flashTime = 8;
    if (health <= 0) {
      level.entities.add(new ParticleSpawner(x-16, y-16, 1, 1000000, TYPE.PLAYER));
      toRemove = true;
      playerAlive = false;
    }
  }

  void shoot(int fireRate) {
    if (time % fireRate == 0) {
      if (mouseX>x) knockBack(1, 0);
      if (mouseX<x) knockBack(-1, 0);
      if (mouseY>y) knockBack(0, 1);
      if (mouseY<y) knockBack(0, -1);
      level.entities.add(new ParticleSpawner(x, y, 1, 99999, TYPE.CASING));
      level.projectiles.add(new Pistol_Bullet(x-16, y-16, mouseX-WIDTH/2-8+ x, mouseY-HEIGHT/2-8 + y));
    } else if (firstShot) {
      if (mouseX>x) knockBack(1, 0);
      if (mouseX<x) knockBack(-1, 0);
      if (mouseY>y) knockBack(0, 1);
      if (mouseY<y) knockBack(0, -1);
      level.entities.add(new ParticleSpawner(x, y, 1, 99999, TYPE.CASING));
      level.projectiles.add(new Pistol_Bullet(x-16, y-16, mouseX-WIDTH/2-8+x, mouseY-HEIGHT/2-8+y));
      firstShot= false;
    }
  } 
  void throwGrenade(int range) {
    level.projectiles.add(new Grenade(x-16, y-16, mouseX-WIDTH/2-8+x, mouseY-HEIGHT/2-8+y, range));
  }

  void knockBack(float xp, float yp) {
    //if (!collision((int)x, (int)y, e)) {
    x-=0;
    y-=0;
    //}
  }

  float px, py, angle;
  void render(Render render) {
    if (grenadePrime>50) {
      pushMatrix();
      translate(WIDTH/2, HEIGHT/2);
      stroke(0);
      strokeWeight(map(dist(0, 0, px, py), 0, 500, 0.15, 3));
      angle = atan2(mouseX-WIDTH/2, mouseY-HEIGHT/2);
      px= grenadePrime * sin(angle);
      py= grenadePrime * cos(angle);
      line(0, 0, px, py);
      translate(px, py);
      rotate(-angle);
      line(0, 0, -8, -8);
      line(0, 0, 8, -8);
      popMatrix();
    }

    if (up) {
      if (anim%20<=10) {
        sprite = Sprite.player_up1;
      } else {
        sprite = Sprite.player_up2;
      }
    }

    if (down) {
      if (anim%20<=10) {
        sprite = Sprite.player_down1;
      } else {
        sprite = Sprite.player_down2;
      }
    }

    if (left) {
      if (anim%20<=10) {
        sprite = Sprite.player_left1;
      } else {
        sprite = Sprite.player_left2;
      }
    }

    if (right) {
      if (anim%20<=10) {
        sprite = Sprite.player_right1;
      } else {
        sprite = Sprite.player_right2;
      }
    }
    fill(0);
    rect(0, 0, 99, 16);
    fill(255, 255, 255);
    rect(0, 0, health, 15);

    render.renderSprite((int)x-16, (int)y-16, sprite, flash);
  }
}