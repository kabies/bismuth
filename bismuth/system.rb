
class Bi::System
  @@fps
  @@assets_dir

  # opts:
  #   assets: asset path
  #   fps: FPS
  #   font: default font
  #   audio_driver: audio driver
  def self.init(opts={})
    @@asset_paths = []

    @@asset_paths.push opts[:assets] || 'assets'
    @@fps = opts[:fps] ? opts[:fps] : 30
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

  def self.asset(name)
    @@asset_paths.each{|path|
      f = File.join(path,name)
      return f if File.exist?(f)
    }
    # asset not found...
    raise "asset #{name} not found"
  end

  def self.add_asset_path(path)
    @@asset_paths.unshift path
  end

  def self.fps
    @@fps
  end

end
