import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.io.FileInputStream;

static class SpriteSheet {
  
  int[] pix;
  int SIZE;
  
  //path is retrieved from main class due to problems converting a PImage to a BufferedImage
 static SpriteSheet sheet = new SpriteSheet(512);

  SpriteSheet(int size) {
    this.SIZE = size;
    pix = new int[size*size];
    load();
  }

  void load() {
    //ImageIO.read(new FileInputStream(path));//SpriteSheet.class.getResource("/Game/spritesheet.png"));
    try {
    BufferedImage image = (BufferedImage) spriteSheet.getImage();
    int w = image.getWidth();
    int h = image.getHeight();
    image.getRGB(0,0,w, h, pix, 0, w);
    }catch (Exception e) {
      e.printStackTrace();
    }
  }
} 