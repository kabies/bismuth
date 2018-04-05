
class Bi::FontCache
  @@cache = {}
  def self.load(filename,fontsize)
    font_id = "#{filename}-#{fontsize}"
    if @@cache[font_id]
      return @@cache[font_id]
    end
    font = Bi::System.read_ttf filename, fontsize
    @@cache[font_id] = font
    font
  end
end
