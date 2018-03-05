class Bi::Gamepad

  AXIS_KEY_TO_SDL2 = {
    L_STICK_Y: SDL2::GameControllers::SDL_CONTROLLER_AXIS_LEFTY,
    L_STICK_X: SDL2::GameControllers::SDL_CONTROLLER_AXIS_LEFTX,
    R_STICK_Y: SDL2::GameControllers::SDL_CONTROLLER_AXIS_RIGHTY,
    R_STICK_X: SDL2::GameControllers::SDL_CONTROLLER_AXIS_RIGHTX,
  }

  BUTTON_KEY_TO_SDL2 = {
    # buttons
    BUTTON_A: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_A,
    BUTTON_B: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_B,
    BUTTON_X: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_X,
    BUTTON_Y: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_Y,
    # Stick Button
    BUTTON_LSTICK: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_LEFTSTICK,
    BUTTON_RSTICK: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_RIGHTSTICK,
    # Shoulder
    BUTTON_LSHOULDER: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_LEFTSHOULDER,
    BUTTON_RSHOULDER: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_RIGHTSHOULDER,
    # Dpad
    BUTTON_UP: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_DPAD_UP,
    BUTTON_LEFT: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_DPAD_LEFT,
    BUTTON_DOWN: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_DPAD_DOWN,
    BUTTON_RIGHT: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_DPAD_RIGHT,
    # others
    BUTTON_BACK: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_BACK,
    BUTTON_GUIDE: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_GUIDE,
    BUTTON_START: SDL2::GameControllers::SDL_CONTROLLER_BUTTON_START,
  }

  def initialize
    if SDL2::Joysticks.num > 0
      js = SDL2::Joysticks::Joystick.new(0)
      p [:get_guid_string, js.get_guid_as_string]

      fc30 = "351200000000000011ab000000000000,FC30  Joystick,a:b1,b:b0,back:b10,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftshoulder:b6,leftstick:b13,lefttrigger:b8,leftx:a0,lefty:a1,rightshoulder:b7,rightstick:b14,righttrigger:b9,rightx:a2,righty:a3,start:b11,x:b4,y:b3,"

      SDL2::GameControllers.add_mapping fc30

      controllers = []
      SDL2::Joysticks::num.times do |i|
        if SDL2::GameControllers::is_gamecontroller_supported?(i)
          p [SDL2::GameControllers::get_name_from_index(i)]
          c = SDL2::GameControllers::GameController.new(i)
          p c.get_mapping
          controllers << c
        else
          p [SDL2::Joysticks::name_from_index(i), :is_gamecontroller_supported, false]
        end
      end

      @gamepad = controllers.first
    else
      @gamepad = nil
    end
  end

end
