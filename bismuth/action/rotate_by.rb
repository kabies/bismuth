
class Bi::Action::RotateBy < Bi::Action::Base

  def initialize(duration,to,&callback)
    super(duration,&callback)
    @to = to
  end

  def start(start_at,node)
    super(start_at,node)
    @from = node.angle
  end

  def progress(rate)
    @node.angle = @from + @to * rate
    if(rate>=1.0)
      @node.angle = @from + @to
    end
    super rate
  end

end