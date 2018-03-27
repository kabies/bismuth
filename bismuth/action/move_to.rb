
class Bi::Action::MoveTo < Bi::Action::Base

  def initialize(duration,x,y,&callback)
    super(duration,&callback)
    @to_x, @to_y = x, y
  end

  def start(start_at,node)
    super(start_at,node)
    @from_x, @from_y = node.x, node.y
  end

  def progress(rate)
    @node.x = (@from_x + (@to_x - @from_x) * rate).to_i
    @node.y = (@from_y + (@to_y - @from_y) * rate).to_i
    if(rate>=1.0)
      @node.x, @node.y = @to_x, @to_y
    end
    super rate
  end

end
