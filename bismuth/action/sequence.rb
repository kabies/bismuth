
class Bi::Action::Sequence
  attr_accessor :start_at
  attr_reader :duration

  def initialize(actions,&callback)
    @actions = actions
    @callback = callback
    @duration = @actions.inject(0){|sum,a| sum+a.duration }
  end

  def start(start_at,node)
    @node = node
    @start_at = start_at

    total_duration = start_at
    @queue = @actions.map{|a|
      # r = (total_duration+a.duration/1000-start_at) * 1000 / @duration
      h = {
        action: a,
        start_at: total_duration,
        # progress_rate: r,
      }
      total_duration += a.duration / 1000
      h
    }

    @current = @queue.shift
    @current[:action].start @start_at,@node
  end

  def update(now)
    rate = (now - @start_at) * 1000 / @duration
    self.progress(rate)
  end

  def progress(rate)
    now = @start_at + rate * @duration / 1000

    while @current do
      e = (now - @current[:start_at]) * 1000
      r = e / @current[:action].duration

      @current[:action].update now
      if r >= 1.0
        @current = @queue.shift
        if @current
          @current[:action].start @current[:start_at], @node
        end
      else
        break
      end
    end

    if rate >= 1.0
      @callback.call if @callback
      return true
    end
    return false
  end

end
