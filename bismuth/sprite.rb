
module Bi::TextureDrawer
  def _draw(renderer)
    return unless @texture
    @texture.alpha_mod = @a
    @texture.set_color_mod( @r, @g, @b )
    @texture.blend_mode = @blendmode || Bi::BLENDMODE_BLEND
    @__dst_rect__ ||= SDL2::Rect.new(0,0,self.w,self.h)
    @__dst_rect__.w,@__dst_rect__.h = self.w, self.h
    renderer.copy @texture, @__texture_rect__, @__dst_rect__
  end
end

class Bi::Sprite < Bi::Node
  include Bi::TextureDrawer
  attr_accessor :filename
  attr_accessor :flipped
  attr_accessor :texture

  def initialize(filename,rect=nil)
    super()

    @filename = filename

    @texture = Bi::TextureCache.get filename

    if rect.is_a? Array
      @__texture_rect__ = SDL2::Rect.new(*rect)
      self.w = rect[2]
      self.h = rect[3]
    elsif rect.is_a? SDL2::Rect
      @__texture_rect__ = SDL2::Rect.new(rect.x,rect.y,rect.w,rect.h)
      self.w = @__texture_rect__.w
      self.h = @__texture_rect__.h
    else
      @__texture_rect__ = SDL2::Rect.new(0,0,@texture.w,@texture.h)
      self.w = @__texture_rect__.w
      self.h = @__texture_rect__.h
    end

    @flipped = false

    # color and alpha
    @r,@g,@b = 0xff,0xff,0xff
    @a = 0xFF
  end

  def flipped?
    @flipped
  end

  def duplicate
    s = Bi::Sprite.new @filename, @__texture_rect__
    s.x = self.x
    s.y = self.y
    s
  end

  def remove_with_destroy
    remove_from_parent
    destroy
  end

  def destroy
    if @texture
      @texture.destroy
      @texture = nil
    end
  end

  def set_texture(texture,x,y,w,h)
    @texture = texture
    @__texture_rect__.x = x
    @__texture_rect__.y = y
    @__texture_rect__.w = w
    @__texture_rect__.h = h
    self.w = w
    self.h = h
  end
end
