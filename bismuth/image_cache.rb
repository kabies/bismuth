
class Bi::ImageCache
  @@cache = {}
  def self.load(filename)
    if @@cache[filename]
      return @@cache[filename]
    end

    if Bi::Archive.instance.include? filename
      file_start = Bi::Archive.instance.at filename
      file_size = Bi::Archive.instance.size filename
      puts "#{filename} load from archive. at #{file_start}, size #{file_size}"
      s = SDL2::Video::Surface::load_partial Bi::Archive.instance.archive_name, file_start, file_size
    else
      s = SDL2::Video::Surface::load Bi::System.asset(filename)
    end
    @@cache[filename] = s
    s
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
      puts "#{__FILE__} ImageCache not found #{filename}"
      return nil
    end

    t = Bi::Texture.new Bi::Window.renderer, s
    @@cache[filename] = t
    t
  end
end
