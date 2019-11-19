class Stamp extends Entity {

  Sprite sprite;
  
  Stamp(float x, float y, Sprite sprite) {
    this.x=x;
    this.y=y;
    this.sprite = sprite;
  }
  
  void tick() {
    
  }
  
  void render(Render render) {
    render.renderSprite((int)x, (int)y, sprite, false);
  }
  
}