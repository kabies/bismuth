# bismuth
$LOAD_PATH.unshift File.dirname(__FILE__)

alias :_original_rand_ :rand
def rand(n)
  if n.is_a? Range
    return n.min if n.min == n.max
    n.min + _original_rand_(n.max-n.min)
  else
    _original_rand_(n)
  end
end


def one_chance_in(a_million)
  rand(a_million) == 0
end

def coinflip
  (1+rand(100)) <= 50
end

module Bismuth
  Version = '0.1.0'
end
# alias
Bi = Bismuth

require 'bismuth/archive'
require 'bismuth/system'
require 'bismuth/image_cache'
require 'bismuth/font_cache'
require 'bismuth/node'
require 'bismuth/sprite'
require 'bismuth/canvas_sprite'
require 'bismuth/text_sprite'
require 'bismuth/menu'
require 'bismuth/scene'
require 'bismuth/timer'
require 'bismuth/action'
require 'bismuth/window'
require 'bismuth/runloop'
require 'bismuth/gamepad'
require 'bismuth/keyboard'
require 'bismuth/mouse'
require 'bismuth/sound'
require 'bismuth/rainbow'

require 'bismuth/animation_yaml_reader'
