
class SceneGraph::Node
  attr_accessor :r,:g,:b,:a
  alias :alpha :a
  alias :alpha= :a=
  # attr_accessor :w,:h
  # attr_accessor :anchor_x,:anchor_y

  def add_child(n)
    @children ||= []
    @children << n
  end

  def set_color(r,g,b,a=nil)
    @r = r
    @g = g
    @b = b
    @a = a if a
    self
  end

  def global_z_order
    @global_z
  end

  def global_z_order=(global_z)
    @global_z = global_z
  end

  def update_with_global_z(renderer)
    @children ||= []
    renderer.__start_draw_with_saved_matrix__ self
    _draw(renderer)
    renderer.__pop_matrix__
    @children.each{|c| c.update renderer }
    renderer.__pop_matrix__
  end

  def update(renderer)
    @children ||= []
    renderer.__start_draw__ self
    if @global_z
      Bi::RunLoop.global_z_node self, @global_z
      renderer.__pop_matrix__
    else
      _draw(renderer)
      renderer.__pop_matrix__
      @children.each{|c| c.update renderer }
    end
    renderer.__pop_matrix__
  end

  def _draw
    # nop
  end

end

module Bi
  BLENDMODE_ADD = SDL2::Video::SDL_BLENDMODE_ADD
  BLENDMODE_MOD = SDL2::Video::SDL_BLENDMODE_MOD
  BLENDMODE_BLEND = SDL2::Video::SDL_BLENDMODE_BLEND
  BLENDMODE_NONE = SDL2::Video::SDL_BLENDMODE_NONE
end

class Bi::Node < SceneGraph::Node

  attr_accessor :parent
  attr_accessor :event_handler
  attr_accessor :visible
  attr_accessor :children
  attr_accessor :blendmode

  def initialize(x=0,y=0,w=0,h=0)
    super
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    @z = 0
    self.anchor_x = 0
    self.anchor_y = 0

    @children = []
    @visible = true

    @event_callbacks = {}
    @event_handler = nil

    # color and alpha
    @blendmode = Bi::BLENDMODE_BLEND
    @r = @g = @b = 0
    @a = 0
  end

  def show
    @visible = true
  end

  def hide
    @visible = false
  end

  def _draw(renderer)
    return if @a == 0
    @__dst_rect__ ||= SDL2::Rect.new(0,0,1,1)
    @__dst_rect__.w, @__dst_rect__.h = self.w, self.h
    renderer.draw_blend_mode = @blendmode
    renderer.set_draw_color( @r, @g, @b, @a )
    renderer.fill_rect @__dst_rect__
  end

  def update(renderer)
    return unless @visible

    # event handler schedule to runloop

    if @event_handler
      Bi::RunLoop.instance.add_event_handler @event_handler
    end
    if @event_callbacks.any?
      Bi::RunLoop.instance.add_event_handler( Proc.new{|ev| self.event_callback(ev) } )
    end

    super(renderer)
  end

  #
  # Scene Graph
  #

  def add_child(node)
    raise "#{node} has parent #{node.parent}" if node.parent
    node.parent = self
    @children << node
  end

  def remove_from_parent
    @parent.remove_child self if @parent
  end

  def remove_child(node)
    raise "#{node} is not child of #{self}" unless node.parent == self
    node.parent = nil
    @children.delete node
    node.cleanup
  end

  def cleanup
    self.remove_all_action
    @children.each{|c| c.cleanup }
  end

  def remove_all_children
    @children.each{|node|
      node.parent = nil
      node.cleanup
    }
    @children.clear
  end

  #
  # Geometry
  #

  def include?(wx,wy)
    lx,ly = self.convert_to_node_space(wx,wy)
    x1 = - self.w * self.anchor_x
    y1 = - self.h * self.anchor_y
    x2 = x1 + self.w
    y2 = y1 + self.h
    x1 <= lx and lx <= x2 and y1 <= ly and ly <= y2
  end

  def intersect?(node)
    me = SDL2::Rect.new(self.x,self.y,self.w,self.h)
    you = SDL2::Rect.new(node.x,node.y,node.w,node.h)
    me.has_intersection? you
  end

  def intersect_in_world?(node)
    #
    # XXX: no rotate, no anchor point...
    #

    if not self.parent or not node.parent
      p [:no_parent]
      return false
    end

    ax,ay = self.parent.convert_to_world_space self.x, self.y
    a_tmp = self.parent.convert_to_world_space self.x+self.w, self.y+self.h
    aw = a_tmp[0] - ax
    ah = a_tmp[1] - ay

    bx,by = node.parent.convert_to_world_space node.x, node.y
    b_tmp = node.parent.convert_to_world_space node.x+node.w, node.y+node.h
    bw = b_tmp[0] - bx
    bh = b_tmp[1] - by

    a = SDL2::Rect.new(ax,ay,aw,ah)
    b = SDL2::Rect.new(bx,by,bw,bh)
    a.has_intersection? b
  end


  #
  # Action
  #

  def run_action(action)
    Bi::RunLoop.instance.run_action action, self
  end

  def remove_action(action)
    Bi::RunLoop.instance.remove_action action, self
  end

  def remove_all_action
    Bi::RunLoop.instance.remove_all_action self
  end

  def action_running?
    Bi::RunLoop.instance.action_running? self
  end

  # Timer

  def add_timer(interval, opts={repeat:true}, &block)
    Bi::RunLoop.add_timer interval, opts, &block
  end

  #
  # Event
  #

  def event_callback(ev)

    @event_callbacks.each{|key,callback|
      case ev.type
      when SDL2::Input::SDL_MOUSEMOTION
        if key == :MOUSE_MOTION
          return callback.call( ev.x, ev.y )
        end
      when SDL2::Input::SDL_MOUSEBUTTONDOWN, SDL2::Input::SDL_MOUSEBUTTONDOWN
        if key == :MOUSE_BUTTON
          return callback.call( ev.button, ev.state, ev.x, ev.y )
        end
      when SDL2::Input::SDL_CONTROLLERAXISMOTION
        if Gamepad::AXIS_KEY_TO_SDL2[key] == ev.axis
          return callback.call( ev.value < 0 ? ev.value / 32768.0 : ev.value / 32767.0 )
        end
      when SDL2::Input::SDL_CONTROLLERBUTTONDOWN, SDL2::Input::SDL_CONTROLLERBUTTONUP
        if Gamepad::BUTTON_KEY_TO_SDL2[key] == ev.button
          return callback.call( ev.state )
        end
      when SDL2::Input::SDL_KEYUP, SDL2::Input::SDL_KEYDOWN
        if key == :KEYBOARD
          return callback.call( ev.keysym.scancode, ev.keysym.modifier, ev.type == SDL2::Input::SDL_KEYDOWN  )
        end
      when SDL2::Input::SDL_TEXTINPUT
        if key == :TEXT
          return callback.call( ev.text )
        end
      end
    }
    return false
  end

  def add_event_callback(keys, &callback)
    if keys.instance_of? Symbol
      @event_callbacks[keys] = callback
    elsif keys.instance_of? Array
      keys.each{|k| @event_callbacks[k] = callback }
    end
  end

end
