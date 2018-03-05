
class Bi::CanvasSprite < Bi::Node
  include Bi::TextureDrawer

  def initialize(w,h)
    super()
    self.w = w
    self.h = h
    @src_rect = SDL2::Rect.new(0,0,w,h)
    texture_format = SDL2::Pixels::SDL_PIXELFORMAT_RGBA8888
    texture_access = SDL2::Video::Texture::SDL_TEXTUREACCESS_TARGET
    @texture = SDL2::Video::Texture.new Window.renderer, texture_format, texture_access, w, h
    @r,@g,@b = 0xff,0xff,0xff
    @a = 0xFF
  end

  def flipped?
    false
  end

  def fill_rect(x,y,w,h,r,g,b,a)
    Window.renderer.target = @texture
    Window.renderer.set_draw_color r,g,b,a
    Window.renderer.fill_rect SDL2::Rect.new(x,y,w,h)
    Window.renderer.target = nil
  end

  def draw_rect(x,y,w,h,r,g,b,a)
    Window.renderer.target = @texture
    Window.renderer.set_draw_color r,g,b,a
    Window.renderer.draw_rect SDL2::Rect.new(x,y,w,h)
    Window.renderer.target = nil
  end

end
