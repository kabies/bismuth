
class Bi::System
  @fps
  @debug

  class << self
    attr :fps, :debug
  end

  # opts:
  #   assets: asset path
  #   archive: archive file path
  #   fps: FPS
  #   font: default font
  #   audio_driver: audio driver
  #   debug: debug mode if true
  def self.init(opts={})

    @debug = !!(opts[:debug])
    if self.debug
      puts "debug mode enabled."
    end

    @@asset_paths = []
    @@asset_paths.push opts[:assets] || 'assets'

    @archive = Bi::Archive.new
    if opts[:archive]
      @archive.load opts[:archive]
      p [opts[:archive], @archive.files] if self.debug
    end

    @fps = opts[:fps] ? opts[:fps] : 30

    if opts[:font]
      Bi::TextSprite.default_font = opts[:font]
    end

    SDL2::Hints::set SDL2::Hints::SDL_HINT_RENDER_DRIVER, "opengl"
    SDL2::init
    SDL2::Video::init
    SDL2::TTF::init

    if Bi::Sound.drivers.include? opts[:audio_driver]
      audio_driver = opts[:audio_driver]
    elsif Bi::Sound.drivers.include? ENV['SDL_AUDIODRIVER']
      audio_driver = ENV['SDL_AUDIODRIVER']
    else
      audio_driver = nil
    end
    SDL2::Audio::init audio_driver if audio_driver
    SDL2::Mixer::init 0
    SDL2::Mixer::open 44100, SDL2::Mixer::MIX_DEFAULT_FORMAT, 2, 1024
  end

  def self.add_asset_path(path)
    @@asset_paths.unshift path
  end

  #
  # archive support
  #

  def self._find_file_(filename)
    @@asset_paths.each{|asset_path|
      path = File.join(asset_path,filename)
      if File.exist? path
        if self.debug
          puts "#{path} load from directory."
        end
        return path
      elsif @archive.include? path
        file_start = @archive.at path
        file_size = @archive.size path
        if self.debug
          puts "#{path} load from #{@archive.archive_name} at #{file_start}, size #{file_size}"
        end
        return @archive.archive_name, file_start, file_size
      end
    }
    return nil
  end

  def self.read_file(filename)
    f = _find_file_(filename)
    if f.is_a? String
      return File.read(f)
    elsif f.is_a? Array
      return @archive.read(f[1],f[2])
    end
    raise "#{filename} not exist."
  end

  def self.read_image(filename)
    f = _find_file_(filename)
    if f.is_a? String
      return SDL2::Video::Surface::load f
    elsif f.is_a? Array
      return SDL2::Video::Surface::load_partial(*f)
    end
    raise "#{filename} not exist."
  end

  def self.read_sound(filename)
    f = _find_file_(filename)
    if f.is_a? String
      return SDL2::Mixer::Chunk.new f
    elsif f.is_a? Array
      return SDL2::Mixer::Chunk::load_partial(*f)
    end
    raise "#{filename} not exist."
  end

  def self.read_music(filename)
    f = _find_file_(filename)
    if f.is_a? String
      return SDL2::Mixer::Music.new f
    elsif f.is_a? Array
      return SDL2::Mixer::Music::load_partial(*f)
    end
    raise "#{filename} not exist."
  end

  def self.read_ttf(filename,fontsize)
    f = _find_file_(filename)
    if f.is_a? String
      return SDL2::TTF::Font.new f, fontsize
    elsif f.is_a? Array
      return SDL2::TTF::Font::load_partial(*f, fontsize)
    end
    raise "#{filename} not exist."
  end

end
