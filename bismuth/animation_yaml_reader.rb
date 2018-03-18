class Bi::AnimationYAMLReader
  attr_reader :default, :animations
  def initialize(file,color={hitbox:[0,0,0,0],hurtbox:[0,0,0,0]})
    @data = YAML.load File.read file
    @default_sprite_name = @data['default']
    @default = Bi::Sprite.new @default_sprite_name
    @color = color
  end
  def read(&callback)
    @animations = @data['animations'].map{|name,data|
      interval = data['interval']
      frames = data['frames'].map{|f|
        sprite = f['sprite']
        hitbox = f['hitbox'].to_a
        hurtbox = f['hurtbox'].to_a
        unit = f['unit'] || 1
        a = Bi::AnimationFrame.new sprite
        a.hitbox[:hitbox] = Bi::HitBox.new hitbox, *(@color[:hitbox])
        a.hitbox[:hurtbox] = Bi::HitBox.new hurtbox, *(@color[:hurtbox])
        a.callback = callback
        a.unit = unit
        a
      }
      animation = Bi::Action::Animate.new(frames,interval)
      animation.name = name
      animation
    }
  end
end
