
class Bi::TextSprite < Bi::Node
  include Bi::TextureDrawer

  attr_reader :text
  attr_reader :font

  def self.default_font=(font)
    @default_font = font
  end

  def self.default_font
    @default_font
  end

  def self.default_color=(color)
    @default_color = color
  end

  def self.default_color
    unless @default_color
      @default_color = [0xFF,0xFF,0xFF]
    end
    @default_color
  end

  # "font" argument:
  #   font: SDL2::TTF::Font
  #   path: TTF file path
  #   size: Font Size
  #   color: [r,g,b,a]
  #
  # OK: {font:TTF_FONT} # size included SDL2::TTF::Font.
  # OK: {path:FONT_PATH,size:18} # use default color
  # NG: {path:FONT_PATH} # size required.
  #
  def initialize(text, font={})
    super()

    if font[:font]
      @font = font[:font]
    else
      @path = font[:path]
      @size = font[:size]
    end

    unless @font and @path
      @path = Bi::TextSprite.default_font
    end

    @a = 0xFF
    if font[:color]
      @r,@g,@b = font[:color]
    else
      @r,@g,@b = Bi::TextSprite.default_color
    end

    unless @font
      @font = Bi::FontCache.load @path, @size
    end

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
      @surface = @font.render_UTF8_blended(@text, 0xFF,0xFF,0xFF,0xFF )
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

