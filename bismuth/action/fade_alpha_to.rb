
class Bi::Action::FadeAlphaTo < Bi::Action::Base

  def initialize(duration,to,&callback)
    super(duration,&callback)
    @to = to
  end

  def start(start_at,node)
    super(start_at,node)
    @from = node.alpha
  end

  def progress(rate)
    @node.alpha = @from + (@to - @from) * rate
    if(rate>=1.0)
      @node.alpha = @to
    end
    super rate
  end
end
