class Particle extends Entity {

  float x, y, z;
  Sprite sprite;
  float xx, yy, zz;
  float xa, ya, za;
  int life;

  Particle(float x, float y, int life, Sprite sprite) {
    this.sprite = sprite;
    this.x=x;
    this.y=y;
    this.xx = x;
    this.yy = y;
    this.life = life;

    this.xa = randomGaussian() + 1.8;
    // if (this.xa<0) xa =0.1;
    this.ya = randomGaussian();
    this.zz = random(1)+2;
  }

  void tick() {
    if (life>=0)life--;
    if (life<=0)toRemove= true;

    za -= 0.1;

    if (zz<0) {
      zz= 0;
      za *=-0.55;
      xa *= 0.4;
      ya *= 0.4;
    }

    tickPos(xx + xa, (yy + ya) + zz + za);
  }

  public void tickPos(double x, double y) {
    if (Collision(x, y)) {
      this.xa *= -0.5;
      this.ya *= -0.8;
      this.za *= -0.5;
    }
    this.xx += xa;
    this.yy += ya;
    this.zz += za;
  }


  public boolean Collision(double x, double y) {
    boolean solid = false;
    for (int c = 0; c < 4; c++) {
      double xt = ((x - c % 2 * 32) / 32);
      double yt = ((y - c / 2 * 32+10) /32);
      if (x < 0) x = 0;
      if (y < 0) y = 0;
      int ix = (int) Math.ceil(xt);
      int iy = (int) Math.ceil(yt);
      if (c % 2 == 0) ix = (int) Math.floor(xt);
      if (c / 2 == 0) iy = (int) Math.floor(yt);
      if (level.getTile(ix, iy).solidToEntities()) {
        return solid = true;
      }
    }
    return solid;
  }



  void render(Render render) {
    render.renderSprite((int)xx, (int)yy + (int)zz, sprite, false);
  }
}