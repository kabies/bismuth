
module Bi::Action

  def self.remove(&callback)
    Bi::Action::Remove.new(callback)
  end

  def self.callback(&callback)
    Bi::Action::Callback.new(&callback)
  end

  def self.wait(duration,&callback)
    Bi::Action::Wait.new duration, &callback
  end

  def self.scale_to(duration,x,y)
    Bi::Action::ScaleTo.new duration,x,y
  end

  def self.rotate_by(duration,to)
    Bi::Action::RotateBy.new duration,to
  end

  def self.rotate_to(duration,to)
    Bi::Action::RotateTo.new duration,to
  end

  def self.move_to(duration,x,y)
    Bi::Action::MoveTo.new duration,x,y
  end

  def self.move_by(duration,x,y)
    Bi::Action::MoveBy.new duration,x,y
  end

  def self.fade_alpha_to(duration,alpha)
    Bi::Action::FadeAlphaTo.new(duration,alpha)
  end

  def self.sequence(actions)
    Bi::Action::Sequence.new actions
  end

  def self.repeat(action,count)
    Bi::Action::RepeatAction.new action, count
  end

  def self.repeat_forever(action)
    Bi::Action::RepeatActionForever.new action
  end


  class FiniteTimeAction
    attr_accessor :start_at
    attr_reader :duration
    attr_accessor :finished

    def initialize(duration, &callback)
      @callback = callback
      @duration = duration
      @start_at = nil
      @node = nil
      @finished = false
    end

    def start(node)
      # return false if self.started?
      @node = node
      @start_at = SDL2::Timer::ticks
      @finished = false
    end

    def started?
      @start_at != nil
    end

    def finished?
      @finished
    end

    def running?
      not @finished and self.started?
    end

    def progress(rate)
      # nop
    end

    def update
      return unless self.running?
      now = SDL2::Timer::ticks
      elapse = now - @start_at
      rate = elapse.to_f / @duration
      progress(rate)
      if elapse >= @duration
        @node.remove_action self
        @finished = true
        @callback.call if @callback
      end
    end
  end

  class Wait < FiniteTimeAction
    # nop!
  end

  # Instant Action
  class Remove < FiniteTimeAction

    def initialize(callback=nil)
      super(0)
      @callback = callback
    end

    def start(node)
      return if @finished
      @finished = true
      @start_at = SDL2::Timer::ticks
      @node = node
      @node.remove_from_parent
      @callback.call if @callback
    end
  end

  # Instant Action
  class Callback < FiniteTimeAction

    def initialize(&callback)
      super(0)
      @callback = callback
    end

    def start(node)
      return if @finished
      @start_at = SDL2::Timer::ticks
      @node = node
      @callback.call node
      node.remove_action self
      @finished = true
    end
  end

  class FadeAlphaTo < FiniteTimeAction

    def initialize(duration,to)
      super(duration)
      @to = to
    end

    def start(node)
      super(node)
      @from = node.alpha
    end

    def progress(rate)
      @node.alpha = @from + (@to - @from) * rate
      if(rate>=1.0)
        @node.alpha = @to
        @finished = true
      end
    end

  end

  class ScaleTo < FiniteTimeAction

    def initialize(duration,x,y)
      super(duration)
      @x_to = x
      @y_to = y
    end

    def start(node)
      super(node)
      @x_from = node.scale_x
      @y_from = node.scale_y
    end

    def progress(rate)
      @node.scale_x = @x_from + (@x_to-@x_from) * rate
      @node.scale_y = @y_from + (@y_to-@y_from) * rate
      if(rate>=1.0)
        @node.scale_x = @x_to
        @node.scale_y = @y_to
        @finished = true
      end
    end

  end

  class RotateBy < FiniteTimeAction

    def initialize(duration,to)
      super(duration)
      @to = to
    end

    def start(node)
      super(node)
      @from = node.angle
    end

    def progress(rate)
      @node.angle = @from + @to * rate
      if(rate>=1.0)
        @node.angle = @from + @to
        @finished = true
      end
    end

  end

  class RotateTo < FiniteTimeAction

    def initialize(duration,to)
      super(duration)
      @to = to
    end

    def start(node)
      super(node)
      @from = node.angle
    end

    def progress(rate)
      @node.angle = @from + (@to - @from) * rate
      if(rate>=1.0)
        @node.angle = @to
        @finished = true
      end
    end

  end

  class MoveTo < FiniteTimeAction

    def initialize(duration,x,y)
      super(duration)
      @to_x, @to_y = x, y
    end

    def start(node)
      super(node)
      @from_x, @from_y = node.x, node.y
    end

    def progress(rate)
      @node.x = (@from_x + (@to_x - @from_x) * rate).to_i
      @node.y = (@from_y + (@to_y - @from_y) * rate).to_i
      if(rate>=1.0)
        @node.x, @node.y = @to_x, @to_y
        @finished = true
      end
    end

  end

  class MoveBy < FiniteTimeAction

    def initialize(duration,x,y)
      super(duration)
      @by_x, @by_y = x, y
    end

    def start(node)
      super(node)
      @from_x, @from_y = node.x, node.y
    end

    def progress(rate)
      @node.x = (@from_x + @by_x * rate).to_i
      @node.y = (@from_y + @by_y * rate).to_i
      if(rate>=1.0)
        @node.x = @from_x + @by_x
        @node.y = @from_y + @by_y
        @finished = true
      end
    end

  end

  class RepeatActionForever

    def initialize(action)
      @action = action
      @duration = action.duration.to_i
      @running = false
    end

    def start(node)
      @node = node
      @running = true
      @start_at = SDL2::Timer::ticks
      @action.start node
    end

    def update
      return unless @running
      now = SDL2::Timer::ticks
      elapse = now - @start_at
      @action.progress elapse.to_f / @duration
      if elapse >= @duration
        @start_at = now
        @action.start @node
      end
    end
  end # class RepeatActionForever

  class RepeatAction

    def initialize(action,count)
      @action = action
      @count = count
      @repeated = 0
      @duration = action.duration.to_i
      @running = false
    end

    def start(node)
      @node = node
      @running = true
      @start_at = SDL2::Timer::ticks
      @action.start node
    end

    def update
      return unless @running
      now = SDL2::Timer::ticks
      elapse = now - @start_at
      @action.progress elapse.to_f / @duration
      if elapse >= @duration
        @repeated += 1
        @start_at = now
        @action.start @node
        if @repeated >= @count
          p [:finished, @repeated]
          @running = false
          @node.remove_action @action
          @node.remove_action self
        end
      end
    end
  end

  class Sequence
    attr_accessor :start_at
    attr_reader :duration
    attr_accessor :finished

    def initialize(actions)
      @actions = actions
      @finished = false
      @start_at = nil
      @duration = @actions.inject(0){|sum,a| sum+a.duration }
      # puts "New Sequence: #{@actions.map(&:class).join(',')} #{self.object_id}"
      super(@duration)
    end

    def started?
      @start_at != nil
    end

    def finished?
      @finished
    end

    def running?
      not @finished and self.started?
    end

    def start(node)
      @node = node
      @running = true
      @start_at = SDL2::Timer::ticks
      @current = @actions.first
      @current.start node
    end

    def update
      return unless @running
      now = SDL2::Timer::ticks
      elapse = now - @start_at

      progress elapse.to_f / @duration

      if elapse >= @duration
        @finished = true
        @node.remove_action self
        @actions.each{|a| @node.remove_action a }
      end
    end

    def progress(rate)
      unless @current
        return
      end

      if rate > 1.0
        @finished = true
      end

      elapse = rate * @duration
      duration_sum = 0
      actions_must_finished = @actions.select{|a|
        duration_sum += a.duration
        duration_sum <= elapse
      }
      actions_must_finished.each{|a|
        a.start @node unless a.started?
        a.progress 1.0 unless a.finished
      }

      duration_sum = 0
      @actions.each{|a|
        if duration_sum < elapse and elapse < duration_sum+a.duration
          @current = a
          @current.start @node unless @current.started?
          dt = elapse - duration_sum
          @current.progress dt / a.duration
          break
        end
        duration_sum += a.duration
      }

    end
  end

end
