
class Bi::Action::RepeatForever

  def initialize(action)
    @action = action
    @duration = action.duration.to_i
  end

  def start(start_at,node)
    @node = node
    @start_at = start_at
    @action.start @start_at,@node
  end

  def update(now)
    rate = (now - @start_at) * 1000 / @duration
    @action.progress rate
    if 1.0 <= rate
      @start_at = now
      @action.start @start_at,@node
    end
    return true
  end
end
