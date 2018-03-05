
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

  def self.run_action(action,target)
    self.instance.run_action action, target
  end

  def self.remove_action(action,target)
    self.instance.remove_action action, target
  end

  def self.remove_all_action(target)
    self.instance.remove_all_action target
  end

  def self.global_z_node(node,z)
    self.instance.global_z_node node, z
  end

  #
  #
  #

  def global_z_node(node,z)
    @global_z_nodes << node
  end

  def run_action(action,target)
    # p [__method__,action.class,target.class]
    @actions << [action, target]
    action.start target
  end

  def remove_action(action,target)
    @actions.delete [action, target]
  end

  def remove_all_action(target)
    @actions.delete_if{|i| i.last == target }
  end

  def set_runnning(running)
    RunLoop::get_loop.running = running
  end

  def initialize()
    @fps = 0
    @event_handlers = []
    @timers = []
    @gamepad = Bi::Gamepad.new
    @callbacks = {}
    @actions = []
    @global_z_nodes = []
  end

  def add_event_handler(handler)
    @event_handlers << handler
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
      @actions.each{|action,target|
        action.update
      }


      end_at = Time.now

      fps_count += 1
      elapse_msec = (end_at-start_at)*1000
      wait_msec = [WAIT_PER_FRAME_MAX - elapse_msec, 1].max

      if Time.now - previous_update > 1
        @fps = fps_count
        # Logger.debug "#{fps_count}FPS E:#{"%.2f" % elapse_msec}ms W:#{"%.2f" % wait_msec}ms"
        previous_update = Time.now
        fps_count = 0
      end

      Bi::Window.renderer.draw_count = 0

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
