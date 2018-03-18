
class Bi::HitBox
  attr_accessor :boxes
  def initialize(rects,r,g,b,a)
    @boxes = rects.map{|rect|
      n = Bi::Node.new
      n.x, n.y, n.w, n.h = rect
      n.r, n.g, n.b, n.a = r,g,b,a
      n
    }
  end
  def set_color(r,g,b,a)
    @boxes.each{|box| box.r, box.g, box.g, box.a = r,g,b,a}
  end
end

class Bi::AnimationFrame
  attr_accessor :hitbox
  attr_accessor :texture
  attr_accessor :callback
  attr_accessor :unit
  def initialize(filename)
    @texture = Bi::TextureCache.get filename
    @hitbox = {}
    @callback = nil
    @unit = 1
  end
end

module Bi::Action
  def self.animation(frames,interval)
    Bi::Action::Animation.new(frames,interval)
  end
end

class Bi::Action::Animate < Bi::Action::FiniteTimeAction

  attr_accessor :callback, :name
  attr_reader :interval, :frames

  def progress(rate)
    i = @timetable.index{|t| rate<t } || @frames.size-1
    if i != @current_frame_index
      set_frame i
    end
  end

  def initialize(frames,interval)
    @total_unit = frames.inject(0){|sum,i|sum+i.unit}.to_i
    super( @total_unit * interval )
    @interval = interval
    @frames = frames
    @timetable = []
    frames.inject(0){|sum,i|
      @timetable << (sum+i.unit) / @total_unit
      sum+i.unit
    }
  end

  def start(node)
    super(node)
    set_frame(0)
  end

  def set_frame(num)
    @current_frame_index = num
    f = @frames[num]
    f.callback.call(f) if f.callback
    @node.set_texture f.texture, 0,0,f.texture.w,f.texture.h
  end
end
