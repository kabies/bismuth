
class Bi::Action::ScaleTo < Bi::Action::Base

  def initialize(duration,x,y,&callback)
    super(duration,&callback)
    @x_to = x
    @y_to = y
  end

  def start(start_at,node)
    super(start_at,node)
    @x_from = node.scale_x
    @y_from = node.scale_y
  end

  def progress(rate)
    @node.scale_x = @x_from + (@x_to-@x_from) * rate
    @node.scale_y = @y_from + (@y_to-@y_from) * rate
    if(rate>=1.0)
      @node.scale_x = @x_to
      @node.scale_y = @y_to
    end
    super rate
  end

end
