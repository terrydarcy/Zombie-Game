class Grenade extends Projectile {

  int timer = 100;
  int xPos, yPos;
  Sprite sprite;

  Grenade(float Ox, float Oy, float Tx, float Ty, int range) {
    this.Ox=Ox;
    this.Oy=Oy;
    this.Tx=Tx;
    this.Ty=Ty;
    sprite = Sprite.grenade;
    this.range = range;//(int) random(100, 300);
    speed = 10;
  }

  void tick() {
    dist = dist(Ox, Oy, Tx, Ty);
    Cx += (Tx-Ox)/dist * speed;
    Cy += (Ty-Oy)/dist * speed;
    if (dist(Ox, Oy, Ox+ Cx, Oy + Cy) > range) {
      speed = 0;
      explode();
    }
    xPos = (int)Ox+(int)Cx;
    yPos = (int)Oy+(int)Cy;
  }

  void explode() {
    //println(timer);
    if (timer>0)timer--;
    if (timer == 20) {
      //  fill(255, 255, 255, 70);
      noStroke();
      //    ellipse(map(xPos, 0, level.w, 0, WIDTH)+ 16, map(yPos, 0, level.h, 0, HEIGHT)+ 16, 100, 100);
      //        ellipse(10,10, 100, 100);



      sprite = Sprite.grenade_explosion0;
      ArrayList<Zombie> zombies = level.getZombies(Ox+Cx, Oy+Cy, 200, this);
      ArrayList<Player> players = level.getPlayers(Ox+Cx, Oy+Cy, 200, this);
      ArrayList<Crate> crates = level.getCrates(Ox+Cx, Oy+Cy, 150, this);

      for (int i =0; i<zombies.size(); i++) {
        float damage = map(dist(xPos, yPos, zombies.get(i).x, zombies.get(i).y), 0, 200, 120, 0);
        zombies.get(i).hurt(xPos, yPos, (int)damage);
      }

      for (int i =0; i<crates.size(); i++) {
        float damage = map(dist(xPos, yPos, crates.get(i).x, crates.get(i).y), 0, 150, 120, 0);
        crates.get(i).hurt(xPos, yPos, (int)damage);
      }

      for (int i =0; i<players.size(); i++) {
        float damage = map(dist(xPos, yPos, players.get(i).x, players.get(i).y), 0, 200, 120, 0);
        players.get(i).hurt(xPos, yPos, (int)damage);
      }
      ArrayList<Particle> particles = level.getParticles(Ox+Cx, Oy+Cy, 100, this);

      for (int i =0; i<particles.size(); i++) {
        float amount =randomGaussian() + 6;
        if (particles.get(i).x<xPos) particles.get(i).xa = -amount;
        if (particles.get(i).x>=xPos) particles.get(i).xa = amount;
        if (particles.get(i).y<yPos) particles.get(i).ya = -amount;
        if (particles.get(i).y>=yPos) particles.get(i).ya = amount;

        //particles.get(i).toRemove = true;
      }

      zombies.clear();
      players.clear();
    }
    if (timer == 15) sprite = Sprite.grenade_explosion1;
    if (timer == 10) sprite = Sprite.grenade_explosion0;
    if (timer == 5) sprite = Sprite.grenade_explosion1;
    if (timer == 0) {
      level.stamp(new Stamp(xPos, yPos, Sprite.grenade_aftermath));
      toRemove= true;
    }
  }

  void render(Render render) {

    render.renderSprite(xPos, yPos, sprite, false);
  }
}