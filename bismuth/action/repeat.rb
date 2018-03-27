
class Bi::Action::Repeat < Bi::Action::Base

  def initialize(action,count,&callback)
    super action.duration.to_i * count, &callback
    @action = action
    @count = count
  end

  def start(start_at,node)
    super start_at, node
    @step = 0
    @action.start start_at, node
  end

  def progress(rate)
    if rate >= 1.0
      @action.progress 1.0
      @callback.call @node if @callback
      return false
    end
    unit = 1.0 / @count
    step = (rate / unit).to_i
    if @step != step
      @action.progress 1.0
      now = @start_at + (rate*@duration/1000)
      @action.start(now,@node)
      @step = step
    end
    r = (rate - unit * step) / unit
    @action.progress r
    super rate
  end

end
