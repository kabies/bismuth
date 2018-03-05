
class Bi::Timer

  attr_accessor :callback
  attr_accessor :running
  attr_accessor :interval

  def initialize(interval,callback,is_loop=false)
    @interval = interval
    @is_loop = is_loop
    @callback = callback
    @start_at = SDL2::Timer::ticks
    @running = true
  end

  def start
    @start_at = SDL2::Timer::ticks
  end

  def update
    if @start_at + @interval <= SDL2::Timer::ticks
      if @is_loop
        @start_at = SDL2::Timer::ticks
      else
        @running = false
      end
      @callback.call()
    end
  end

end
