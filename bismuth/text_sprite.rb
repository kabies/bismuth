
class Bi::TextSprite < Bi::Node
  include Bi::TextureDrawer

  class << self
    attr_accessor :default_font, :default_color, :default_size
  end
  @default_font = nil
  @default_color = [0xFF,0xFF,0xFF,0xFF]
  @default_size = 18

  # opts:
  #   font: TTF file name
  #   size: font size
  #   color: [r,g,b,a]
  def initialize(text, opts={})
    super()
    @font = opts[:font] || Bi::TextSprite.default_font
    @size = opts[:size] || Bi::TextSprite.default_size
    @r,@g,@b,@a = opts[:color] || Bi::TextSprite.default_color
    @a = 0xFF unless @a
    @font_path = Bi::System.asset @font
    @font_file = Bi::FontCache.load @font, @size
    set_text(text)
  end

  def flipped?
    false
  end

  def set_text(text)
    @text = text
    begin
      @surface.free if @surface
      # opaque white
      @surface = @font_file.render_UTF8_blended(@text, 0xFF,0xFF,0xFF,0xFF )
    rescue => e
      @surface = nil
      self.w = 0
      self.h = 0
    end
    if @surface
      @texture.destroy if @texture
      @texture = SDL2::Video::Texture.new Bi::Window.renderer, @surface
      @src_rect = SDL2::Rect.new(0,0,@surface.width,@surface.height)
      self.w = @surface.width
      self.h = @surface.height
    else
      @texture = nil
      @src_rect = SDL2::Rect.new(0,0,0,0)
    end
  end

end

