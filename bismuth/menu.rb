
class Bi::MenuItem < Bi::TextSprite

  def initialize(text, opts={}, &callback)
    super(text,opts)
    @callback = callback
  end

  def callback
    @callback.call if @callback
  end
end # MenuItem

class Bi::Menu < Bi::Node
  def initialize(items)
    super()
    @a = 0
    @index = 0
    @items = items
    @event_handler = Proc.new {|ev| next self.event_handle(ev) }

    add_event_callback(:BUTTON_UP){|value|
      if value
        select_up
        update_select_state
        next true
      end
    }
    add_event_callback(:BUTTON_DOWN){|value|
      if value
        select_down
        update_select_state
        next true
      end
    }
    add_event_callback(:BUTTON_A){|value|
      if value
        @items[@index].callback
        next true
      end
    }

  end

  def align_vertical(margin)
    item_y = 0
    @items.each_with_index{|item,i|
      add_child(item)
      item.x = self.w / 2
      item.y = self.h / 2 + item_y
      item_y += item.h + margin
    }
  end

  def update_select_state
    @items.each{|item| item.set_color 0x99,0x99,0x99 }
    @items[@index].set_color 0xff,0x99,0
  end

  def select_up
    @index -= 1
    @index = 0 if @index >= @items.size
    @index = @items.size - 1 if @index < 0
  end

  def select_down
    @index += 1
    @index = 0 if @index >= @items.size
    @index = @items.size - 1 if @index < 0
  end

  def on_key_down(scancode)
    case scancode
    when SDL2::Input::Keyboard::SDL_SCANCODE_RETURN
      @items[@index].callback
    when SDL2::Input::Keyboard::SDL_SCANCODE_DOWN
      select_down
    when SDL2::Input::Keyboard::SDL_SCANCODE_UP
      select_up
    end

    update_select_state
  end

  def event_handle(ev)
    case ev.type
    when SDL2::Input::SDL_KEYDOWN
      on_key_down(ev.keysym.scancode)
      return true
    when SDL2::Input::SDL_MOUSEBUTTONDOWN
      @items.each{|item|
        if item.include? ev.x, ev.y
          item.callback
          return true
        end
      }
    when SDL2::Input::SDL_MOUSEMOTION
      @items.each_with_index{|item,i|
        if item.include? ev.x, ev.y
          @index = i
          update_select_state
          return true
        end
      }
    end
    return false
  end
end # class Bi::Menu

