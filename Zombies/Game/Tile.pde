static class Tile {

  Sprite sprite;

  static Tile grass = new GrassTile(Sprite.grass);
  static Tile voidTile = new VoidTile(Sprite.voidSprite);
  static Tile wallFront = new WallTile(Sprite.wall_front);
  static Tile wallTop = new WallTile(Sprite.wall_top);
  static Tile wallEdge = new WallTile(Sprite.wall_edge);
  static Tile stone = new StoneTile(Sprite.stone);
  static Tile bars = new WallTile(Sprite.bars);
  static Tile barsTop = new WallTile(Sprite.barsTop);

  Tile(Sprite sprite) {
    this.sprite= sprite;
  }
  
  boolean solid() {
   return false; 
  }
  
  boolean solidToEntities() {
   return false; 
  }

  void tick() {
  }

  void render(int x, int y, Render render) {
  }
}

static class GrassTile extends Tile {
  GrassTile(Sprite sprite) {
    super(sprite);
  }
  void tick() {
  }
  boolean solid() {
   return false; 
  }
    
  boolean solidToEntities() {
   return false; 
  }
  void render(int x, int y, Render render) {
    render.renderSprite(x*32, y*32, sprite, false);
  }
}

static class VoidTile extends Tile {
  VoidTile(Sprite sprite) {
    super(sprite);
  }
  void tick() {
  }
  boolean solid() {
   return true; 
  }
    
  boolean solidToEntities() {
   return true; 
  }
  void render(int x, int y, Render render) {
    render.renderSprite(x*32, y*32, sprite, false);
  }
}

static class WallTile extends Tile {
  WallTile(Sprite sprite) {
    super(sprite);
  }
  void tick() {
  }
   boolean solid() {
   return true; 
  }   
  boolean solidToEntities() {
   return true; 
  }
  void render(int x, int y, Render render) {
    render.renderSprite(x*32, y*32, sprite, false);
  }
}

static class StoneTile extends Tile {
  StoneTile(Sprite sprite) {
    super(sprite);
  }
  void tick() {
  }
   boolean solid() {
   return false; 
  }
   boolean solidToEntities() {
   return false; 
  }
  void render(int x, int y, Render render) {
    render.renderSprite(x*32, y*32, sprite, false);
  }
}