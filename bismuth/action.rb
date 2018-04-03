
module Bi::Action
end

# base action
require 'bismuth/action/base'

# finite time actions
require 'bismuth/action/animate'
require 'bismuth/action/callback'
require 'bismuth/action/fade_alpha_to'
require 'bismuth/action/move_by'
require 'bismuth/action/move_to'
require 'bismuth/action/remove'
require 'bismuth/action/rotate_by'
require 'bismuth/action/rotate_to'
require 'bismuth/action/scale_to'
require 'bismuth/action/wait'

# composite
require 'bismuth/action/repeat_forever'
require 'bismuth/action/repeat'
require 'bismuth/action/sequence'

module Bi::Action

  def self.animate(frames,interval,&callback)
    Bi::Action::Animate.new(frames,interval,&callback)
  end

  def self.remove(&callback)
    Bi::Action::Remove.new(&callback)
  end

  def self.callback(&callback)
    Bi::Action::Callback.new(&callback)
  end

  def self.wait(duration,&callback)
    Bi::Action::Wait.new duration, &callback
  end

  def self.scale_to(duration,x,y,&callback)
    Bi::Action::ScaleTo.new duration,x,y,&callback
  end

  def self.rotate_by(duration,to,&callback)
    Bi::Action::RotateBy.new duration,to,&callback
  end

  def self.rotate_to(duration,to,&callback)
    Bi::Action::RotateTo.new duration,to,&callback
  end

  def self.move_to(duration,x,y,&callback)
    Bi::Action::MoveTo.new duration,x,y,&callback
  end

  def self.move_by(duration,x,y,&callback)
    Bi::Action::MoveBy.new duration,x,y,&callback
  end

  def self.fade_alpha_to(duration,alpha,&callback)
    Bi::Action::FadeAlphaTo.new(duration,alpha,&callback)
  end

  #
  # composite
  #

  def self.repeat_forever(action)
    Bi::Action::RepeatForever.new action
  end

  def self.repeat(action,count,&callback)
    Bi::Action::Repeat.new action, count, &callback
  end

  def self.sequence(actions,&callback)
    Bi::Action::Sequence.new actions,&callback
  end

end
