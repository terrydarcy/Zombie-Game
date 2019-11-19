import java.util.Collections;
import java.util.Comparator; 

class Level {

  int w, h;
  PImage image;
  int[] data;

  ArrayList<Entity> entities = new ArrayList<Entity>();
  ArrayList<Zombie> zombies = new ArrayList<Zombie>();
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  ArrayList<Player> players = new ArrayList<Player>();
  ArrayList<Stamp> stamps = new ArrayList<Stamp>();
  ArrayList<Particle> particles  = new ArrayList<Particle>();
  ArrayList<Crate> crates  = new ArrayList<Crate>();

  Table table;

  private Comparator<Zombie> zombieSorter = new Comparator<Zombie>() {
    int compare(Zombie z0, Zombie z1) {
      if (z1.y < z0.y) return +1;
      if (z1.y > z0.y) return -1;
      return 0;
    }
  };

  private Comparator<Crate> crateSorter = new Comparator<Crate>() {
    int compare(Crate c0, Crate c1) {
      if (c1.y < c0.y) return +1;
      if (c1.y > c0.y) return -1;
      return 0;
    }
  };

  Level(String path) {
    table = loadTable(path);
    this.w = table.getRowCount();
    this.h = table.getColumnCount();
    data= new int[table.getColumnCount()* table.getRowCount()];
    for (int y= 0; y<table.getRowCount(); y++) {
      for (int x= 0; x<table.getColumnCount(); x++) {
        data[x+y*table.getRowCount()] = table.getInt(y, x);
      }
    }



    int protection = 0;
    while (zombies.size() < 0) {
      int x = (int) random(16, w*32-16);
      int y = (int) random(32, h*32-16 );

      boolean overlapping = false;
      for (int j = 0; j< zombies.size(); j++) {
        Zombie other = zombies.get(j);
        if (!(x+w <= other.x || other.x + other.w <= x || y+h <= other.y || other.y + other.h <= y)) {
          overlapping = true;
          break;
        }
        //for (int c = 0; c < 4; c++) {
        //  double xt = ((x ) - c % 2 * 12-10) / 32;
        //  double yt = ((y ) - c / 2 * 13 -3) / 32;


        //  int ix = (int) Math.ceil(xt);
        //  int iy = (int) Math.ceil(yt);
        //  if (c % 2 == 0) ix = (int) Math.floor(xt);
        //  if (c / 2 == 0) iy = (int) Math.floor(yt);
        //  if (getTile(ix, iy).solid()) overlapping = true;
        //}
      }
      if (!overlapping) {
        zombies.add(new Zombie(x, y, w, h));
      }
      protection++;
      if (protection>100000) {
        break;
      }
    }

    generateCrates();
    generateZombies();
    generatePlayers();
    image = loadImage("res/levels/Map1.png");
  }

  boolean levelCollision(int x, int y, int size, int xOffset, int yOffset) {
    boolean solid = false;
    for (int c = 0; c < 4; c++) {
      int xt = ((x - c % 2 * size + xOffset+10) / 32);
      int yt = ((y - c / 2 * size + yOffset/2+20) / 32);
      if (x < 0) x = 0;
      if (y < 0) y = 0;
      if (getTile(xt, yt).solidToEntities()) {
        return solid = true;
      }
    }
    return solid;
  }




  ArrayList<Zombie> getZombies(float x, float y, int r, Entity e) {
    ArrayList<Zombie> result= new ArrayList<Zombie>();
    for (int i =0; i<zombies.size(); i++) {
      if (dist(x, y, zombies.get(i).x, zombies.get(i).y) < r) {
        result.add(zombies.get(i));
      } else {
        result.remove(zombies.get(i));
      }
    }
    return result;
  }

  ArrayList<Player> getPlayers(float x, float y, int r, Entity e) {
    ArrayList<Player> result= new ArrayList<Player>();
    for (int i =0; i<players.size(); i++) {
      if (dist(x, y, players.get(i).x, players.get(i).y) < r) {
        result.add(players.get(i));
      } else {
        result.remove(players.get(i));
      }
    }
    return result;
  }

  ArrayList<Crate> getCrates(float x, float y, int r, Entity e) {
    ArrayList<Crate> result= new ArrayList<Crate>();
    for (int i =0; i<crates.size(); i++) {
      if (dist(x, y, crates.get(i).x, crates.get(i).y) < r) {
        result.add(crates.get(i));
      } else {
        result.remove(crates.get(i));
      }
    }
    return result;
  }

  ArrayList<Particle> getParticles(float x, float y, int r, Entity e) {
    ArrayList<Particle> result= new ArrayList<Particle>();
    for (int i =0; i<particles.size(); i++) {
      if (dist(x, y, particles.get(i).x, particles.get(i).y) < r) {
        result.add(particles.get(i));
      } else {
        result.remove(particles.get(i));
      }
    }
    return result;
  }

  void tick() {
    if (addZombies&& frameCount%5==0) zombies.add(new Zombie((int)random(w*32), (int)random(h*32), 32, 32));


    for (int i =0; i<projectiles.size(); i++) {
      projectiles.get(i).tick();
      if (projectiles.get(i).toRemove) projectiles.remove(i);
    }

    for (int i =0; i<crates.size(); i++) {
      crates.get(i).tick();
      if (crates.get(i).toRemove) crates.remove(i);
    }

    for (int i =0; i<entities.size(); i++) {
      entities.get(i).tick();
      if (entities.get(i).toRemove) entities.remove(i);
    }
    for (int i =0; i<zombies.size(); i++) {
      zombies.get(i).tick();
      if (zombies.get(i).toRemove) zombies.remove(i);
    }

    for (int i =0; i<stamps.size(); i++) {
      stamps.get(i).tick();
      if (stamps.get(i).toRemove) stamps.remove(i);
    }

    for (int i =0; i<players.size(); i++) {
      players.get(i).tick();
      if (players.get(i).toRemove) players.remove(i);
    }

    for (int i =0; i<particles.size(); i++) {
      particles.get(i).tick();
      if (particles.get(i).toRemove) particles.remove(i);
    }
  }

  //  void movePlayer(int dx, int dy) {
  //    players.move(dx, dy);
  //  }

  boolean renderAbove = false;
  boolean doOnce = true;
  int tt = 10;

  void stamp(Stamp s) {
    stamps.add(s);
  }

  void render(Render render, int xScroll, int yScroll) {
    render.setOffsets(xScroll, yScroll);
    int x0 = xScroll/32;
    int x1 = (xScroll+ render.w+32)/32;
    int y0 = yScroll/32;
    int y1 = (yScroll+ render.h+32)/32;

    if (x0<32) x0-=32;

    if (y0<32) y0-=32;

    for (int y = y0; y< y1; y++) {
      for (int x = x0; x< x1; x++) {
        getTile(x, y).render(x, y, render);
      }
    }


    // render.renderMap(0, 0, w, h, image); 
    for (int i =0; i<particles.size(); i++) {
      particles.get(i).render(render);
    }

    for (int i =0; i<stamps.size(); i++) {
      stamps.get(i).render(render);
    }

    for (int i =0; i<projectiles.size(); i++) {
      projectiles.get(i).render(render);
    }
    if (tt>0)tt--;

    if (!renderAbove || tt > 0) {
      for (int i =0; i<players.size(); i++) {
        players.get(i).render(render);
      }
    } 
    for (int i =0; i<projectiles.size(); i++) {
      projectiles.get(i).render(render);
    }


    for (int i =0; i<crates.size(); i++) {
      Collections.sort(crates, crateSorter);
      crates.get(i).render(render);
      if (playerAlive && dist(level.players.get(0).x, level.players.get(0).y, crates.get(i).x, crates.get(i).y-5)<= 40) {
        if (level.players.get(0).y>=crates.get(i).y) {
          renderAbove = true;
          if (!doOnce) {
            tt= 5;
            doOnce = true;
          }
        } else {
          renderAbove = false;
          if (doOnce) {
            tt = 5;
            doOnce= false;
          }
        }
      }
    }
    for (int i =0; i<zombies.size(); i++) {
      Collections.sort(zombies, zombieSorter);
      zombies.get(i).render(render);
      if (playerAlive && dist(level.players.get(0).x, level.players.get(0).y, zombies.get(i).x, zombies.get(i).y-5)<= 30) {
        if (level.players.get(0).y>=zombies.get(i).y) {
          renderAbove = true;
          if (!doOnce) {
            tt= 5;
            doOnce = true;
          }
        } else {
          renderAbove = false;
          if (doOnce) {
            tt = 5;
            doOnce= false;
          }
        }
      }
    }

    if (renderAbove || tt >0) {
      for (int i =0; i<players.size(); i++) {
        players.get(i).render(render);
      }
    }
  }
  void generateCrates() {
    for (int yy= 0; yy<table.getRowCount(); yy++) {
      for (int xx= 0; xx<table.getColumnCount(); xx++) {
        if (data[xx+yy*table.getRowCount()] == 22) {
          crates.add(new Crate(xx*32, yy*32-4));
        }
      }
    }
  }
  void generateZombies() {
    for (int yy= 0; yy<table.getRowCount(); yy++) {
      for (int xx= 0; xx<table.getColumnCount(); xx++) {
        if (data[xx+yy*table.getRowCount()] == 60) {
          zombies.add(new Zombie(xx*32+16, yy*32,32,32));
        }
      }
    }
  }
void generatePlayers() {
    for (int yy= 0; yy<table.getRowCount(); yy++) {
      for (int xx= 0; xx<table.getColumnCount(); xx++) {
        if (data[xx+yy*table.getRowCount()] == 12) {
    players.add(new Player(xx*32, yy*32+2, 32, 32));
        }
      }
    }
  }

  Tile getTile(int x, int y) {
    if (x<0 || x>=w || y<0 || y>= h) return Tile.voidTile;
    if (data[x+y*table.getRowCount()] == 3) return Tile.grass;
    
    if (data[x+y*table.getRowCount()] == 4) return Tile.stone;
    if (data[x+y*table.getRowCount()] == 22) return Tile.stone;
    if (data[x+y*table.getRowCount()] == 60) return Tile.stone;
    if (data[x+y*table.getRowCount()] == 12) return Tile.stone;
    
    if (data[x+y*table.getRowCount()] == 20) return Tile.wallEdge;
    if (data[x+y*table.getRowCount()] == 21) return Tile.wallTop;
    if (data[x+y*table.getRowCount()] == 36) return Tile.wallFront;
    if (data[x+y*table.getRowCount()] == 5) return Tile.bars;
    if (data[x+y*table.getRowCount()] == 6) return Tile.barsTop;


    return Tile.voidTile;
  }
}