static class Sprite {


  int[] pix; 
  int x, y, w, h;
  int SIZE;
  int col;

  static Sprite voidSprite = new Sprite(2, 1, 32);
  static Sprite grass = new Sprite(3, 0, 32);
  static Sprite stone = new Sprite(4, 0, 32);
  static Sprite wall_edge = new Sprite(4, 1, 32);  
  static Sprite wall_front = new Sprite(4, 2, 32);
  static Sprite wall_top = new Sprite(5, 1, 32);
  static Sprite crate = new Sprite(6, 1, 32);

  static Sprite bars = new Sprite(5, 0, 32);
  static Sprite barsTop = new Sprite(6, 0, 32);


  static Sprite player_dead = new Sprite(11, 0, 32);
  static Sprite zombie_dead = new Sprite(11, 1, 32);

  static Sprite player_down0 = new Sprite(12, 0, 32);
  static Sprite player_down1 = new Sprite(12, 1, 32);
  static Sprite player_down2 = new Sprite(12, 2, 32);

  static Sprite player_up0 = new Sprite(13, 0, 32);
  static Sprite player_up1 = new Sprite(13, 1, 32);
  static Sprite player_up2 = new Sprite(13, 2, 32);

  static Sprite player_right0 = new Sprite(14, 0, 32);
  static Sprite player_right1 = new Sprite(14, 1, 32);
  static Sprite player_right2 = new Sprite(14, 2, 32);

  static Sprite player_left0 = new Sprite(15, 0, 32);
  static Sprite player_left1 = new Sprite(15, 1, 32);
  static Sprite player_left2 = new Sprite(15, 2, 32);
  ////
  static Sprite zombie_down0 = new Sprite(12, 3, 32);
  static Sprite zombie_down1 = new Sprite(12, 4, 32);
  static Sprite zombie_down2 = new Sprite(12, 5, 32);

  static Sprite zombie_up0 = new Sprite(13, 3, 32);
  static Sprite zombie_up1 = new Sprite(13, 4, 32);
  static Sprite zombie_up2 = new Sprite(13, 5, 32);

  static Sprite zombie_right0 = new Sprite(14, 3, 32);
  static Sprite zombie_right1 = new Sprite(14, 4, 32);
  static Sprite zombie_right2 = new Sprite(14, 5, 32);

  static Sprite zombie_left0 = new Sprite(15, 3, 32);
  static Sprite zombie_left1 = new Sprite(15, 4, 32);
  static Sprite zombie_left2 = new Sprite(15, 5, 32);

  static Sprite robot_down0 = new Sprite(10, 0, 32);
  static Sprite robot_down1 = new Sprite(10, 1, 32);
  static Sprite robot_down2 = new Sprite(10, 2, 32);


  static Sprite bullet = new Sprite(0, 1, 32);
  static Sprite grenade = new Sprite(1, 1, 32);
  static Sprite grenade_explosion0 = new Sprite(1, 3, 32);
  static Sprite grenade_explosion1 = new Sprite(1, 2, 32);
  static Sprite grenade_aftermath = new Sprite(1, 4, 32);
  static Sprite test = new Sprite(2, 0, 32);

  static Sprite Test_particle = new Sprite(6, 3, 0xff101010, 1);
  static Sprite bloodParticle = new Sprite(6, 3, 0xffAA3F4E, 1);
  static Sprite bulletParticle = new Sprite(4, 2, 0xff303030, 1);
  static Sprite casingParticle = new Sprite(4, 2, 0xffFFC200, 1);
  static Sprite woodParticle = new Sprite(4, 2, 0xffAA5600, 1);

  Sprite(int x, int y, int size) {
    this. SIZE = size;
    this.w = SIZE;
    this.h = SIZE;
    this.x = x*size;
    this.y = y*size;
    pix = new int[size*size];
    getCol();
  }

  Sprite(int w, int h, int col, int differ) {
    this.col = col;
    this.w = w;
    this.h = h;
    this.SIZE = -1;
    pix = new int[w*h];
    getColWH(w, h, col);
  }

  void getCol() {
    for (int y = 0; y < SIZE; y++) {
      for (int x = 0; x < SIZE; x++) {
        pix[x + y * SIZE] = SpriteSheet.sheet.pix[(x+this.x) + (y+this.y) * SpriteSheet.sheet.SIZE];
      }
    }
  }

  void getColWH(int w, int h, int col) {
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        pix[x + y * w] = col;
      }
    }
  }
}