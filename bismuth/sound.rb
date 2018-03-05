
class Bi::Sound

  def self.init
    SDL2::Mixer::init 0
    SDL2::Mixer::open 44100, SDL2::Mixer::MIX_DEFAULT_FORMAT, 2, 4096
    SDL2::Mixer::allocate_channels 32
  end

  def self.drivers
    SDL2::Audio.drivers
  end

  def self.driver_name
    SDL2::Audio.current_driver
  end

  def self.info
    chunk_decoders = SDL2::Mixer.get_num_chuck_decoder.times.map{|i| SDL2::Mixer.get_chunk_decoder(i) }
    music_decoders = SDL2::Mixer.get_num_music_decoder.times.map{|i| SDL2::Mixer.get_music_decoder(i) }
    p [:chunk_decoders, chunk_decoders, :music_decoders, music_decoders]
  end

  def initialize(filename)
    @filename = filename

    if Bi::Archive.instance.include? filename
      file_start = Bi::Archive.instance.at filename
      file_size = Bi::Archive.instance.size filename
      @sound = SDL2::Mixer::Chunk::load_partial Bi::Archive.instance.archive_name, file_start, file_size
    else
      @sound = SDL2::Mixer::Chunk.new Bi::System.asset(filename)
    end

    @channel = -1
  end

  def play(opts={})
    if opts[:repeat] or opts[:loop]
      loop_count = -1
    else
      loop_count =  0
    end
    channel = opts[:override] ? @channel : -1
    @channel = @sound.play( channel, loop_count )
  end

end
