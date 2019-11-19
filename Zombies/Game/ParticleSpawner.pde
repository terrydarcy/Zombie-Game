enum TYPE {
  BLOOD, CASING, ZOMBIE, PLAYER, CRATE, BULLET 
}

class ParticleSpawner extends Entity {

  ParticleSpawner(float x, float y, float amount, int life, TYPE type) {
    for (int i = 0; i < amount; i++) {

      if (type == TYPE.BLOOD) {
        level.particles.add(new Particle(x, y, (int)random(life, life+50), Sprite.bloodParticle));
      }
      
      if (type == TYPE.CRATE) {
        level.particles.add(new Particle(x, y, (int)random(life, life+50), Sprite.woodParticle));
      }

      if (type == TYPE.CASING) {
        level.particles.add(new Particle(x, y, (int)random(life, life+50), Sprite.casingParticle));
      }

      if (type == TYPE.BULLET) {
        level.particles.add(new Particle(x, y, (int)random(life, life+50), Sprite.bulletParticle));
      }
            
      
      if (type == TYPE.ZOMBIE) {
        level.particles.add(new Particle(x, y, (int)random(life, life+50), Sprite.zombie_dead));
      }
      
        if (type == TYPE.PLAYER) {
        level.particles.add(new Particle(x, y, (int)random(life, life+50), Sprite.player_dead));
      }
    }
    toRemove = true;
  }

  void tick() {
  }
}