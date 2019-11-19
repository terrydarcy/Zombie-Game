class Render {

  int w, h;
  int[] pix;
  int xOffset, yOffset;

  Render(int w, int h, int[] pix) {
    this.w = w;
    this.h = h;
    this.pix = pix;
  }

  void clear() {
    for (int i =0; i < pix.length; i++) {
      pix[i] = color(0);
    }
  }

  void renderSprite(int xa, int ya, Sprite sprite, boolean flash) {
    xa -= xOffset;
    ya -= yOffset;
    for (int y = 0; y < sprite.h; y++) {
      int ys = y+ya;
      for (int x = 0; x < sprite.w; x++) {
        int xs = x+xa;
        if (xs <= -sprite.w || xs >= w || ys<= 0|| ys >= h) break;
        if (xs<0) xs = 0;
        int col = 0;
        if (sprite.SIZE == -1) {
          col = color(sprite.col);
        } else {
          col =color(sprite.pix[x + y * sprite.w]);
        }
        if (flash) {
          if (col != color(0xffff00ff)) pix[xs + ys * w] = color(0xffffffff);
        } else {
          if (col != color(0xffff00ff)) pix[xs + ys * w] = col;
        }
      }
    }
  }

  void renderWH(int xa, int ya, Sprite sprite) {
    xa -= xOffset;
    ya -= yOffset;
    for (int y = 0; y < sprite.h; y++) {
      int ys = y+ya;
      for (int x = 0; x < sprite.w; x++) {
        int xs = x+xa;
        if (xs < -sprite.w || xs >= w || ys< 0|| ys >= h) break;
        pix[xs + ys * w] =color(sprite.col);
      }
    }
  }

  void renderMap(int xp, int yp, int w, int h, PImage image) {
    for (int y = xp; y < yp+h; y++) {
      for (int x = yp; x < xp+w; x++) {
        pix[x+y*w] = image.pixels[x+y*w];
      }
    }
  }

  void setOffsets(int xScroll, int yScroll) {
    this.xOffset = xScroll;
    this.yOffset = yScroll;
  }
}