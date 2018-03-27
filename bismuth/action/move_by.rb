
class Bi::Action::MoveBy < Bi::Action::Base

  def initialize(duration,x,y,&callback)
    super(duration,&callback)
    @by_x, @by_y = x, y
  end

  def start(start_at,node)
    super(start_at,node)
    @from_x, @from_y = node.x, node.y
  end

  def progress(rate)
    @node.x = (@from_x + @by_x * rate).to_i
    @node.y = (@from_y + @by_y * rate).to_i
    if(rate>=1.0)
      @node.x = @from_x + @by_x
      @node.y = @from_y + @by_y
    end
    super rate
  end

end
