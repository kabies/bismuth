
class Bi::Window
  X = SDL2::Video::Window::SDL_WINDOWPOS_UNDEFINED
  Y = SDL2::Video::Window::SDL_WINDOWPOS_UNDEFINED
  FLAGS = SDL2::Video::Window::SDL_WINDOW_OPENGL

  @@window = nil
  @@renderer = nil
  @@w = 0
  @@h = 0

  def self.w
    @@w
  end

  def self.h
    @@h
  end

  def self.title=(title)
    Bi::Window.set_title title
  end

  def self.set_title(title)
    Bi::Window.window.title = title
  end

  def self.window
    @@window
  end

  def self.renderer
    @@renderer
  end

  def self.drivers
    SDL2::Video.video_drivers
  end

  def self.driver_name
    SDL2::Video.current_driver
  end

  def self.renderer_name
    @@renderer.name
  end

  def self.make_window(w,h)
    @@w = w
    @@h = h
    @@window = SDL2::Video::Window.new "", X, Y, w, h, FLAGS
    @@renderer = SDL2::Video::Renderer.new @@window
    @@renderer.draw_blend_mode = SDL2::Video::SDL_BLENDMODE_BLEND
    @@window
  end
end
