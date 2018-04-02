
class Bi::ImageCache
  @@cache = {}
  def self.load(filename)
    if @@cache[filename]
      return @@cache[filename]
    end
    @@cache[filename] = Bi::System.read_image filename
  end
end

class Bi::Texture < SDL2::Video::Texture
  alias :w :width
  alias :h :height
end

class Bi::TextureCache
  @@cache = {}
  def self.get(filename)
    if @@cache[filename]
      return @@cache[filename]
    end

    s = Bi::ImageCache::load filename
    unless s
      if Bi::System.debug
        puts "Bi::TextureCache: #{filename} not found"
      end
      return nil
    end

    t = Bi::Texture.new Bi::Window.renderer, s
    @@cache[filename] = t
    t
  end
end
