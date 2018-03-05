
class Bi::FontCache
  @@cache = {}
  def self.load(fontpath,fontsize)
    font_id = "#{fontpath}-#{fontsize}"
    if @@cache[font_id]
      return @@cache[font_id]
    end
    font = SDL2::TTF::Font.new fontpath, fontsize
    @@cache[font_id] = font
    font
  end
end
