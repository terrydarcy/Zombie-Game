class Pistol_Bullet extends Projectile {

  int xOffset = 0, yOffset = 0;

  Pistol_Bullet(float Ox, float Oy, float Tx, float Ty) {
    this.Ox=Ox;
    this.Oy=Oy;
    this.Tx=Tx;
    this.Ty=Ty;

    range = 600;
    speed = 20;

    int recoil = 15;

    xOffset = (int)random(-recoil, recoil);
    yOffset = (int)random(-recoil, recoil);
  }

  void tick() {
    dist = dist(Ox, Oy, Tx, Ty);
    if (dist(Ox, Oy, Tx, Ty)< 100) xOffset = yOffset = 0;
    Cx += ((Tx+xOffset)-Ox)/dist * speed;
    Cy += ((Ty+yOffset)-Oy)/dist * speed;
    if (dist(Ox, Oy, Ox+ Cx, Oy + Cy) > range)toRemove = true;

    if (level.levelCollision((int)Cx+(int)Ox, ((int)Cy+(int)Oy)-10, 13, 13, 13)){
           level.entities.add(new ParticleSpawner(((int)Cx+(int)Ox)+10, (int)Cy+(int)Oy, (int)random(20, 50), 100, TYPE.BULLET));
     //speed=0;
     toRemove = true;
    }
  }

  void render(Render render) {
    int xa = (int)Ox+(int)Cx;
    int ya = (int)Oy+(int)Cy;
    render.renderSprite(xa, ya, Sprite.bullet, false);
  }
}