
class SDL2::Video::Renderer
  attr_accessor :draw_count
  alias :__original_start_draw__ :__start_draw__
  def __start_draw__(obj)
    @draw_count = 1 + @draw_count.to_i
    self.__original_start_draw__ obj
  end
end

class Bi::RunLoop
  include ::Singleton

  attr_accessor :scene
  attr_accessor :window
  attr_accessor :running
  attr_accessor :fps
  attr_accessor :timers
  attr_accessor :callbacks

  def self.fps
    Bi::RunLoop.instance.fps
  end

  def self.add_timer(interval,opts={repeat:true},&callback)
    t = Bi::Timer.new(interval, callback, opts[:repeat])
    self.instance.timers << t
    t
  end

  def self.remove_timer(timer)
    self.instance.timers.delete timer
  end

  def self.schedule_update(&callback)
    self.instance.timers << Bi::Timer.new(0, callback, true)
  end

  def self.add_callback(key,callback)
    self.instance.callbacks[key] = callback
  end

  def self.replace_scene(scene)
    self.instance.scene = scene
  end

  def self.global_z_node(node,z)
    self.instance.global_z_node node, z
  end

  #
  #
  #

  def initialize()
    @fps = 0
    @event_handlers = []
    @timers = []
    @gamepad = Bi::Gamepad.new
    @callbacks = {}
    @node_actions = {}
    @global_z_nodes = []
  end

  #
  # actions
  #

  def run_action(action,node)
    @node_actions[node] ||= []
    @node_actions[node] << action
    action.start Time.now, node
  end

  def remove_action(action,node)
    if @node_actions[node]
      i = @node_actions[node].index(action)
      @node_actions[node][i] = nil if i
    end
  end

  def remove_all_action(node)
    if @node_actions[node]
      @node_actions[node].fill{nil}
    end
  end

  def action_running?(node)
    ! @node_actions[node].empty?
  end

  def update_actions
    now = Time.now
    @node_actions.each{|node,actions|
      actions.size.times{|i|
        next unless actions[i]
        unless actions[i].update now
          # remove done action
          actions[i] = nil
        end
      }
    }
    @node_actions.delete_if{|node,actions|
      actions.compact!
      actions.empty?
    }
  end

  #
  #
  #

  def global_z_node(node,z)
    @global_z_nodes << node
  end

  def set_runnning(running)
    RunLoop::get_loop.running = running
  end

  def add_event_handler(handler)
    @event_handlers << handler
  end

  def rendering
    Bi::Window.renderer.draw_count = 0
    Bi::Window.renderer.set_draw_color( 0,0,0,0 )
    Bi::Window.renderer.clear

    if @scene
      @scene.update Bi::Window.renderer

      # global z nodes
      @global_z_nodes.each{|node|
        node.update_with_global_z Bi::Window.renderer
      }
    end

    Bi::Window.renderer.present

    @global_z_nodes.clear
  end

  def run_with_scene(scene)
    self.scene = scene
    @running = true

    previous_update = Time.now
    fps_count = 0
    WAIT_PER_FRAME_MAX = 1.0 / Bi::System.fps * 1000
    running = true

    while @running
      start_at = Time.now

      #
      # Event Handler
      #
      # SDL2::GameControllers::update
      while ev = SDL2::Input::poll()

        if ev.type == SDL2::Input::SDL_QUIT
          @running = false
          break
        end

        @event_handlers.reverse.each{|handler|
          if handler
            break if handler.call ev
          end
        }
      end
      @event_handlers.clear

      #
      # Timer Handler
      #
      @timers.each{|t| t.update }
      @timers.reject!{|t| t.running == false }

      #
      # Actions
      #
      self.update_actions

      #
      # Rendering
      #
      self.rendering

      end_at = Time.now

      fps_count += 1
      elapse_msec = (end_at-start_at)*1000
      wait_msec = [WAIT_PER_FRAME_MAX - elapse_msec, 1].max

      now = Time.now
      if now - previous_update > 1
        @fps = fps_count
        if Bi::System.debug
          elapse_str = "%.2f" % elapse_msec
          wait_str = "%.2f" % wait_msec
          node_count = Bi::Window.renderer.draw_count
          action_count = @node_actions.values.inject(0){|sum,actions| sum+actions.size }
          puts "[#{now}] #{fps_count}FPS / Work #{elapse_str}ms / Wait #{wait_str}ms / #{node_count}nodes / #{action_count}actions"
        end
        previous_update = now
        fps_count = 0
      end

      SDL2::delay wait_msec
    end
    quit(0)
  rescue => e
    STDERR.puts e.inspect
    STDERR.puts e.backtrace.join("\n")
    quit(1)
  end

  def quit(return_code)
    Bi::Window.window.destroy
    SDL2::Video::quit
    SDL2::quit
    exit(return_code.to_i)
  end

end
