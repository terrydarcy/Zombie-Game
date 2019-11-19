class Entity {

  int cBoxW;
  int cBoxH;
  float speed;
  float x, y;
  int w, h;
  boolean toRemove = false;
  float px = 0, py = 0, pcBoxW= 32, pcBoxH = 32;

  boolean collision(float xa, float ya, Entity mob) {
    //  if ((x + xa) <= 16 || (x + xa) >= width-cBoxW || (y + ya) <= 16 || (y + ya) >= height-cBoxH) {
    //   return true;
    //}

    for (int c = 0; c < 4; c++) {
      double xt = ((x + xa) - c % 2 * 12-10) / 32;
      double yt = ((y + ya) - c / 2 * 13 -3) / 32;


      int ix = (int) Math.ceil(xt);
      int iy = (int) Math.ceil(yt);
      if (c % 2 == 0) ix = (int) Math.floor(xt);
      if (c / 2 == 0) iy = (int) Math.floor(yt);
      if (level.getTile(ix, iy).solid()) return true;
    }
    if (playerAlive) {
      px = level.players.get(0).x;
      py = level.players.get(0).y;
      pcBoxW = level.players.get(0).cBoxW;
      pcBoxH = level.players.get(0).cBoxH;
    }
    for (int j=0; j<level.zombies.size(); j++) {
      Zombie other = level.zombies.get(j);


      if (other != this && !(x+xa+cBoxW <= other.x || other.x+other.cBoxW <= x+xa || y+ya+cBoxH <= other.y || other.y+other.cBoxH <= y+ya) 
        || (!(mob instanceof Player) && !(x+xa+cBoxW <= px|| px+pcBoxW <= x+xa || y+ya+cBoxH <= py || py+pcBoxH <= y+ya))) {
        return true;
      }

      for (int c = 0; c< level.crates.size(); c++) {
        Crate crate = level.crates.get(c);
        if (!(mob instanceof Player) && !(x+xa+cBoxW <= crate.x || crate.x+32<= x+xa || y+ya+cBoxH <= crate.y || crate.y+32 <= y+ya) ) {
          return true;
        }
      }
    }
    for (int c = 0; c< level.crates.size(); c++) {
      Crate crate = level.crates.get(c);
      if ( !(crate.x+38 <= px+xa|| px+pcBoxW+xa <= crate.x+10 || crate.y+30 <= py+ya || py+pcBoxH+ya <= crate.y+10)) {
        return true;
      }
    }


    return false;
  }

  boolean crateCollision(float xa, float ya) {
    if (playerAlive) {
      px = level.players.get(0).x;
      py = level.players.get(0).y;
      pcBoxW = level.players.get(0).cBoxW;
      pcBoxH = level.players.get(0).cBoxH;
    }
    for (int c = 0; c< level.crates.size(); c++) {
      Crate crate = level.crates.get(c);
      if (crate== this && !(crate.x+38 <= px+xa|| px+pcBoxW+xa <= crate.x+10 || crate.y+30 <= py+ya || py+pcBoxH+ya <= crate.y+10)) {
        return true;
      }
    }
    return false;
  }
  boolean tileCollision(float xa, float ya, Entity mob) {
    for (int c = 0; c < 4; c++) {
      double xt = ((x + xa) - c % 2 * 2+2) / 32;
      double yt = ((y + ya) - c / 2 *2 +5) / 32;


      int ix = (int) Math.ceil(xt);
      int iy = (int) Math.ceil(yt);
      if (c % 2 == 0) ix = (int) Math.floor(xt);
      if (c / 2 == 0) iy = (int) Math.floor(yt);
      if (level.getTile(ix, iy).solid()) return true;
    }
     
    for (int j=0; j<level.zombies.size(); j++) {
      Zombie other = level.zombies.get(j);

      for (int c = 0; c< level.crates.size(); c++) {
        Crate crate = level.crates.get(c);
        if (!(mob instanceof Player) && !(other.x+other.xa+other.cBoxW <= crate.x+crate.xa || crate.x+crate.xa+32<= other.x+other.xa || other.y+other.ya+other.cBoxH <= crate.y+crate.ya || crate.y+32+crate.ya <= other.y+other.ya) ) {
          return true;
        }
      }
    }
    for (int c = 0; c< level.crates.size(); c++) {
      Crate crate = level.crates.get(c);
      if (crate!= this && !(x+xa+32 <= crate.x+crate.xa || crate.x+32+crate.xa<= x+xa || y+ya+32 <= crate.y+crate.ya || crate.y+crate.ya+32 <= y+ya) ) {
        return true;
      }
    }
    return false;
  }



  boolean projectileCollision(float xa, float ya, Entity mob) {
    for (int j=0; j<level.projectiles.size(); j++) {
      Projectile p = level.projectiles.get(j);   
      if (!(mob instanceof Player) && !(p instanceof Grenade) && !(x+cBoxW+xa-9 <= p.Cx+p.Ox || p.Cx+p.Ox+32 <= x+xa || y+ya+cBoxH+5 <= p.Cy+p.Oy || p.Cy+p.Oy+32 <= y+ya)) {
        p.toRemove = true;
        return true;
      }
    }
    return false;
  }

  void tick() {
  }

  void render(Render render) {
  }
}