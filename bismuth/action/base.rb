
class Bi::Action::Base
  attr_accessor :start_at
  attr_reader :duration
  attr_reader :node

  def initialize(duration, &callback)
    @callback = callback
    @duration = duration
    @start_at = nil
    @node = nil
  end

  def start(start_at,node)
    @node = node
    @start_at = start_at
  end

  def progress(rate)
    if rate >= 1.0
      @callback.call(@node) if @callback
      return false
    end
    return true
  end

  def update(now)
    elapse = (now - @start_at)*1000
    rate = @duration == 0 ? 1.0 : elapse / @duration
    progress(rate)
  end
end
