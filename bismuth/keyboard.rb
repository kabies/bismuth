
module Bi::Keyboard
  def self.name(keycode)
    Bi::Keyboard.constants.each{|c|
      return c if Bi::Keyboard.const_get(c) == keycode
    }
    return nil
  end

  def self.shift?(mod)
    (mod & SDL2::Input::Keyboard::KMOD_SHIFT) != 0
  end

  def self.ctrl?(mod)
    (mod & SDL2::Input::Keyboard::KMOD_CTRL) != 0
  end

  def self.alt?(mod)
    (mod & SDL2::Input::Keyboard::KMOD_ALT) != 0
  end

  # UNKNOWN = SDL2::Input::Keyboard::SDL_SCANCODE_UNKNOWN
  A = SDL2::Input::Keyboard::SDL_SCANCODE_A
  B = SDL2::Input::Keyboard::SDL_SCANCODE_B
  C = SDL2::Input::Keyboard::SDL_SCANCODE_C
  D = SDL2::Input::Keyboard::SDL_SCANCODE_D
  E = SDL2::Input::Keyboard::SDL_SCANCODE_E
  F = SDL2::Input::Keyboard::SDL_SCANCODE_F
  G = SDL2::Input::Keyboard::SDL_SCANCODE_G
  H = SDL2::Input::Keyboard::SDL_SCANCODE_H
  I = SDL2::Input::Keyboard::SDL_SCANCODE_I
  J = SDL2::Input::Keyboard::SDL_SCANCODE_J
  K = SDL2::Input::Keyboard::SDL_SCANCODE_K
  L = SDL2::Input::Keyboard::SDL_SCANCODE_L
  M = SDL2::Input::Keyboard::SDL_SCANCODE_M
  N = SDL2::Input::Keyboard::SDL_SCANCODE_N
  O = SDL2::Input::Keyboard::SDL_SCANCODE_O
  P = SDL2::Input::Keyboard::SDL_SCANCODE_P
  Q = SDL2::Input::Keyboard::SDL_SCANCODE_Q
  R = SDL2::Input::Keyboard::SDL_SCANCODE_R
  S = SDL2::Input::Keyboard::SDL_SCANCODE_S
  T = SDL2::Input::Keyboard::SDL_SCANCODE_T
  U = SDL2::Input::Keyboard::SDL_SCANCODE_U
  V = SDL2::Input::Keyboard::SDL_SCANCODE_V
  W = SDL2::Input::Keyboard::SDL_SCANCODE_W
  X = SDL2::Input::Keyboard::SDL_SCANCODE_X
  Y = SDL2::Input::Keyboard::SDL_SCANCODE_Y
  Z = SDL2::Input::Keyboard::SDL_SCANCODE_Z
  KEY_1 = SDL2::Input::Keyboard::SDL_SCANCODE_1
  KEY_2 = SDL2::Input::Keyboard::SDL_SCANCODE_2
  KEY_3 = SDL2::Input::Keyboard::SDL_SCANCODE_3
  KEY_4 = SDL2::Input::Keyboard::SDL_SCANCODE_4
  KEY_5 = SDL2::Input::Keyboard::SDL_SCANCODE_5
  KEY_6 = SDL2::Input::Keyboard::SDL_SCANCODE_6
  KEY_7 = SDL2::Input::Keyboard::SDL_SCANCODE_7
  KEY_8 = SDL2::Input::Keyboard::SDL_SCANCODE_8
  KEY_9 = SDL2::Input::Keyboard::SDL_SCANCODE_9
  KEY_0 = SDL2::Input::Keyboard::SDL_SCANCODE_0
  RETURN = SDL2::Input::Keyboard::SDL_SCANCODE_RETURN
  ESCAPE = SDL2::Input::Keyboard::SDL_SCANCODE_ESCAPE
  BACKSPACE = SDL2::Input::Keyboard::SDL_SCANCODE_BACKSPACE
  TAB = SDL2::Input::Keyboard::SDL_SCANCODE_TAB
  SPACE = SDL2::Input::Keyboard::SDL_SCANCODE_SPACE
  MINUS = SDL2::Input::Keyboard::SDL_SCANCODE_MINUS
  EQUALS = SDL2::Input::Keyboard::SDL_SCANCODE_EQUALS
  LEFTBRACKET = SDL2::Input::Keyboard::SDL_SCANCODE_LEFTBRACKET
  RIGHTBRACKET = SDL2::Input::Keyboard::SDL_SCANCODE_RIGHTBRACKET
  BACKSLASH = SDL2::Input::Keyboard::SDL_SCANCODE_BACKSLASH
  NONUSHASH = SDL2::Input::Keyboard::SDL_SCANCODE_NONUSHASH
  SEMICOLON = SDL2::Input::Keyboard::SDL_SCANCODE_SEMICOLON
  APOSTROPHE = SDL2::Input::Keyboard::SDL_SCANCODE_APOSTROPHE
  GRAVE = SDL2::Input::Keyboard::SDL_SCANCODE_GRAVE
  COMMA = SDL2::Input::Keyboard::SDL_SCANCODE_COMMA
  PERIOD = SDL2::Input::Keyboard::SDL_SCANCODE_PERIOD
  SLASH = SDL2::Input::Keyboard::SDL_SCANCODE_SLASH
  CAPSLOCK = SDL2::Input::Keyboard::SDL_SCANCODE_CAPSLOCK
  F1 = SDL2::Input::Keyboard::SDL_SCANCODE_F1
  F2 = SDL2::Input::Keyboard::SDL_SCANCODE_F2
  F3 = SDL2::Input::Keyboard::SDL_SCANCODE_F3
  F4 = SDL2::Input::Keyboard::SDL_SCANCODE_F4
  F5 = SDL2::Input::Keyboard::SDL_SCANCODE_F5
  F6 = SDL2::Input::Keyboard::SDL_SCANCODE_F6
  F7 = SDL2::Input::Keyboard::SDL_SCANCODE_F7
  F8 = SDL2::Input::Keyboard::SDL_SCANCODE_F8
  F9 = SDL2::Input::Keyboard::SDL_SCANCODE_F9
  F10 = SDL2::Input::Keyboard::SDL_SCANCODE_F10
  F11 = SDL2::Input::Keyboard::SDL_SCANCODE_F11
  F12 = SDL2::Input::Keyboard::SDL_SCANCODE_F12
  PRINTSCREEN = SDL2::Input::Keyboard::SDL_SCANCODE_PRINTSCREEN
  SCROLLLOCK = SDL2::Input::Keyboard::SDL_SCANCODE_SCROLLLOCK
  PAUSE = SDL2::Input::Keyboard::SDL_SCANCODE_PAUSE
  INSERT = SDL2::Input::Keyboard::SDL_SCANCODE_INSERT
  HOME = SDL2::Input::Keyboard::SDL_SCANCODE_HOME
  PAGEUP = SDL2::Input::Keyboard::SDL_SCANCODE_PAGEUP
  DELETE = SDL2::Input::Keyboard::SDL_SCANCODE_DELETE
  ENDKEY = SDL2::Input::Keyboard::SDL_SCANCODE_END
  PAGEDOWN = SDL2::Input::Keyboard::SDL_SCANCODE_PAGEDOWN
  RIGHT = SDL2::Input::Keyboard::SDL_SCANCODE_RIGHT
  LEFT = SDL2::Input::Keyboard::SDL_SCANCODE_LEFT
  DOWN = SDL2::Input::Keyboard::SDL_SCANCODE_DOWN
  UP = SDL2::Input::Keyboard::SDL_SCANCODE_UP
  NUMLOCKCLEAR = SDL2::Input::Keyboard::SDL_SCANCODE_NUMLOCKCLEAR
  KP_DIVIDE = SDL2::Input::Keyboard::SDL_SCANCODE_KP_DIVIDE
  KP_MULTIPLY = SDL2::Input::Keyboard::SDL_SCANCODE_KP_MULTIPLY
  KP_MINUS = SDL2::Input::Keyboard::SDL_SCANCODE_KP_MINUS
  KP_PLUS = SDL2::Input::Keyboard::SDL_SCANCODE_KP_PLUS
  KP_ENTER = SDL2::Input::Keyboard::SDL_SCANCODE_KP_ENTER
  KP_1 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_1
  KP_2 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_2
  KP_3 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_3
  KP_4 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_4
  KP_5 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_5
  KP_6 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_6
  KP_7 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_7
  KP_8 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_8
  KP_9 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_9
  KP_0 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_0
  KP_PERIOD = SDL2::Input::Keyboard::SDL_SCANCODE_KP_PERIOD
  NONUSBACKSLASH = SDL2::Input::Keyboard::SDL_SCANCODE_NONUSBACKSLASH
  APPLICATION = SDL2::Input::Keyboard::SDL_SCANCODE_APPLICATION
  POWER = SDL2::Input::Keyboard::SDL_SCANCODE_POWER
  KP_EQUALS = SDL2::Input::Keyboard::SDL_SCANCODE_KP_EQUALS
  F13 = SDL2::Input::Keyboard::SDL_SCANCODE_F13
  F14 = SDL2::Input::Keyboard::SDL_SCANCODE_F14
  F15 = SDL2::Input::Keyboard::SDL_SCANCODE_F15
  F16 = SDL2::Input::Keyboard::SDL_SCANCODE_F16
  F17 = SDL2::Input::Keyboard::SDL_SCANCODE_F17
  F18 = SDL2::Input::Keyboard::SDL_SCANCODE_F18
  F19 = SDL2::Input::Keyboard::SDL_SCANCODE_F19
  F20 = SDL2::Input::Keyboard::SDL_SCANCODE_F20
  F21 = SDL2::Input::Keyboard::SDL_SCANCODE_F21
  F22 = SDL2::Input::Keyboard::SDL_SCANCODE_F22
  F23 = SDL2::Input::Keyboard::SDL_SCANCODE_F23
  F24 = SDL2::Input::Keyboard::SDL_SCANCODE_F24
  EXECUTE = SDL2::Input::Keyboard::SDL_SCANCODE_EXECUTE
  HELP = SDL2::Input::Keyboard::SDL_SCANCODE_HELP
  MENU = SDL2::Input::Keyboard::SDL_SCANCODE_MENU
  SELECT = SDL2::Input::Keyboard::SDL_SCANCODE_SELECT
  STOP = SDL2::Input::Keyboard::SDL_SCANCODE_STOP
  AGAIN = SDL2::Input::Keyboard::SDL_SCANCODE_AGAIN
  UNDO = SDL2::Input::Keyboard::SDL_SCANCODE_UNDO
  CUT = SDL2::Input::Keyboard::SDL_SCANCODE_CUT
  COPY = SDL2::Input::Keyboard::SDL_SCANCODE_COPY
  PASTE = SDL2::Input::Keyboard::SDL_SCANCODE_PASTE
  FIND = SDL2::Input::Keyboard::SDL_SCANCODE_FIND
  MUTE = SDL2::Input::Keyboard::SDL_SCANCODE_MUTE
  VOLUMEUP = SDL2::Input::Keyboard::SDL_SCANCODE_VOLUMEUP
  VOLUMEDOWN = SDL2::Input::Keyboard::SDL_SCANCODE_VOLUMEDOWN
  KP_COMMA = SDL2::Input::Keyboard::SDL_SCANCODE_KP_COMMA
  KP_EQUALSAS400 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_EQUALSAS400
  INTERNATIONAL1 = SDL2::Input::Keyboard::SDL_SCANCODE_INTERNATIONAL1
  INTERNATIONAL2 = SDL2::Input::Keyboard::SDL_SCANCODE_INTERNATIONAL2
  INTERNATIONAL3 = SDL2::Input::Keyboard::SDL_SCANCODE_INTERNATIONAL3
  INTERNATIONAL4 = SDL2::Input::Keyboard::SDL_SCANCODE_INTERNATIONAL4
  INTERNATIONAL5 = SDL2::Input::Keyboard::SDL_SCANCODE_INTERNATIONAL5
  INTERNATIONAL6 = SDL2::Input::Keyboard::SDL_SCANCODE_INTERNATIONAL6
  INTERNATIONAL7 = SDL2::Input::Keyboard::SDL_SCANCODE_INTERNATIONAL7
  INTERNATIONAL8 = SDL2::Input::Keyboard::SDL_SCANCODE_INTERNATIONAL8
  INTERNATIONAL9 = SDL2::Input::Keyboard::SDL_SCANCODE_INTERNATIONAL9
  LANG1 = SDL2::Input::Keyboard::SDL_SCANCODE_LANG1
  LANG2 = SDL2::Input::Keyboard::SDL_SCANCODE_LANG2
  LANG3 = SDL2::Input::Keyboard::SDL_SCANCODE_LANG3
  LANG4 = SDL2::Input::Keyboard::SDL_SCANCODE_LANG4
  LANG5 = SDL2::Input::Keyboard::SDL_SCANCODE_LANG5
  LANG6 = SDL2::Input::Keyboard::SDL_SCANCODE_LANG6
  LANG7 = SDL2::Input::Keyboard::SDL_SCANCODE_LANG7
  LANG8 = SDL2::Input::Keyboard::SDL_SCANCODE_LANG8
  LANG9 = SDL2::Input::Keyboard::SDL_SCANCODE_LANG9
  ALTERASE = SDL2::Input::Keyboard::SDL_SCANCODE_ALTERASE
  SYSREQ = SDL2::Input::Keyboard::SDL_SCANCODE_SYSREQ
  CANCEL = SDL2::Input::Keyboard::SDL_SCANCODE_CANCEL
  CLEAR = SDL2::Input::Keyboard::SDL_SCANCODE_CLEAR
  PRIOR = SDL2::Input::Keyboard::SDL_SCANCODE_PRIOR
  RETURN2 = SDL2::Input::Keyboard::SDL_SCANCODE_RETURN2
  SEPARATOR = SDL2::Input::Keyboard::SDL_SCANCODE_SEPARATOR
  OUT = SDL2::Input::Keyboard::SDL_SCANCODE_OUT
  OPER = SDL2::Input::Keyboard::SDL_SCANCODE_OPER
  CLEARAGAIN = SDL2::Input::Keyboard::SDL_SCANCODE_CLEARAGAIN
  CRSEL = SDL2::Input::Keyboard::SDL_SCANCODE_CRSEL
  EXSEL = SDL2::Input::Keyboard::SDL_SCANCODE_EXSEL
  KP_00 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_00
  KP_000 = SDL2::Input::Keyboard::SDL_SCANCODE_KP_000
  THOUSANDSSEPARATOR = SDL2::Input::Keyboard::SDL_SCANCODE_THOUSANDSSEPARATOR
  DECIMALSEPARATOR = SDL2::Input::Keyboard::SDL_SCANCODE_DECIMALSEPARATOR
  CURRENCYUNIT = SDL2::Input::Keyboard::SDL_SCANCODE_CURRENCYUNIT
  CURRENCYSUBUNIT = SDL2::Input::Keyboard::SDL_SCANCODE_CURRENCYSUBUNIT
  KP_LEFTPAREN = SDL2::Input::Keyboard::SDL_SCANCODE_KP_LEFTPAREN
  KP_RIGHTPAREN = SDL2::Input::Keyboard::SDL_SCANCODE_KP_RIGHTPAREN
  KP_LEFTBRACE = SDL2::Input::Keyboard::SDL_SCANCODE_KP_LEFTBRACE
  KP_RIGHTBRACE = SDL2::Input::Keyboard::SDL_SCANCODE_KP_RIGHTBRACE
  KP_TAB = SDL2::Input::Keyboard::SDL_SCANCODE_KP_TAB
  KP_BACKSPACE = SDL2::Input::Keyboard::SDL_SCANCODE_KP_BACKSPACE
  KP_A = SDL2::Input::Keyboard::SDL_SCANCODE_KP_A
  KP_B = SDL2::Input::Keyboard::SDL_SCANCODE_KP_B
  KP_C = SDL2::Input::Keyboard::SDL_SCANCODE_KP_C
  KP_D = SDL2::Input::Keyboard::SDL_SCANCODE_KP_D
  KP_E = SDL2::Input::Keyboard::SDL_SCANCODE_KP_E
  KP_F = SDL2::Input::Keyboard::SDL_SCANCODE_KP_F
  KP_XOR = SDL2::Input::Keyboard::SDL_SCANCODE_KP_XOR
  KP_POWER = SDL2::Input::Keyboard::SDL_SCANCODE_KP_POWER
  KP_PERCENT = SDL2::Input::Keyboard::SDL_SCANCODE_KP_PERCENT
  KP_LESS = SDL2::Input::Keyboard::SDL_SCANCODE_KP_LESS
  KP_GREATER = SDL2::Input::Keyboard::SDL_SCANCODE_KP_GREATER
  KP_AMPERSAND = SDL2::Input::Keyboard::SDL_SCANCODE_KP_AMPERSAND
  KP_DBLAMPERSAND = SDL2::Input::Keyboard::SDL_SCANCODE_KP_DBLAMPERSAND
  KP_VERTICALBAR = SDL2::Input::Keyboard::SDL_SCANCODE_KP_VERTICALBAR
  KP_DBLVERTICALBAR = SDL2::Input::Keyboard::SDL_SCANCODE_KP_DBLVERTICALBAR
  KP_COLON = SDL2::Input::Keyboard::SDL_SCANCODE_KP_COLON
  KP_HASH = SDL2::Input::Keyboard::SDL_SCANCODE_KP_HASH
  KP_SPACE = SDL2::Input::Keyboard::SDL_SCANCODE_KP_SPACE
  KP_AT = SDL2::Input::Keyboard::SDL_SCANCODE_KP_AT
  KP_EXCLAM = SDL2::Input::Keyboard::SDL_SCANCODE_KP_EXCLAM
  KP_MEMSTORE = SDL2::Input::Keyboard::SDL_SCANCODE_KP_MEMSTORE
  KP_MEMRECALL = SDL2::Input::Keyboard::SDL_SCANCODE_KP_MEMRECALL
  KP_MEMCLEAR = SDL2::Input::Keyboard::SDL_SCANCODE_KP_MEMCLEAR
  KP_MEMADD = SDL2::Input::Keyboard::SDL_SCANCODE_KP_MEMADD
  KP_MEMSUBTRACT = SDL2::Input::Keyboard::SDL_SCANCODE_KP_MEMSUBTRACT
  KP_MEMMULTIPLY = SDL2::Input::Keyboard::SDL_SCANCODE_KP_MEMMULTIPLY
  KP_MEMDIVIDE = SDL2::Input::Keyboard::SDL_SCANCODE_KP_MEMDIVIDE
  KP_PLUSMINUS = SDL2::Input::Keyboard::SDL_SCANCODE_KP_PLUSMINUS
  KP_CLEAR = SDL2::Input::Keyboard::SDL_SCANCODE_KP_CLEAR
  KP_CLEARENTRY = SDL2::Input::Keyboard::SDL_SCANCODE_KP_CLEARENTRY
  KP_BINARY = SDL2::Input::Keyboard::SDL_SCANCODE_KP_BINARY
  KP_OCTAL = SDL2::Input::Keyboard::SDL_SCANCODE_KP_OCTAL
  KP_DECIMAL = SDL2::Input::Keyboard::SDL_SCANCODE_KP_DECIMAL
  KP_HEXADECIMAL = SDL2::Input::Keyboard::SDL_SCANCODE_KP_HEXADECIMAL
  LCTRL = SDL2::Input::Keyboard::SDL_SCANCODE_LCTRL
  LSHIFT = SDL2::Input::Keyboard::SDL_SCANCODE_LSHIFT
  LALT = SDL2::Input::Keyboard::SDL_SCANCODE_LALT
  LGUI = SDL2::Input::Keyboard::SDL_SCANCODE_LGUI
  RCTRL = SDL2::Input::Keyboard::SDL_SCANCODE_RCTRL
  RSHIFT = SDL2::Input::Keyboard::SDL_SCANCODE_RSHIFT
  RALT = SDL2::Input::Keyboard::SDL_SCANCODE_RALT
  RGUI = SDL2::Input::Keyboard::SDL_SCANCODE_RGUI
  MODE = SDL2::Input::Keyboard::SDL_SCANCODE_MODE
  AUDIONEXT = SDL2::Input::Keyboard::SDL_SCANCODE_AUDIONEXT
  AUDIOPREV = SDL2::Input::Keyboard::SDL_SCANCODE_AUDIOPREV
  AUDIOSTOP = SDL2::Input::Keyboard::SDL_SCANCODE_AUDIOSTOP
  AUDIOPLAY = SDL2::Input::Keyboard::SDL_SCANCODE_AUDIOPLAY
  AUDIOMUTE = SDL2::Input::Keyboard::SDL_SCANCODE_AUDIOMUTE
  MEDIASELECT = SDL2::Input::Keyboard::SDL_SCANCODE_MEDIASELECT
  WWW = SDL2::Input::Keyboard::SDL_SCANCODE_WWW
  MAIL = SDL2::Input::Keyboard::SDL_SCANCODE_MAIL
  CALCULATOR = SDL2::Input::Keyboard::SDL_SCANCODE_CALCULATOR
  COMPUTER = SDL2::Input::Keyboard::SDL_SCANCODE_COMPUTER
  AC_SEARCH = SDL2::Input::Keyboard::SDL_SCANCODE_AC_SEARCH
  AC_HOME = SDL2::Input::Keyboard::SDL_SCANCODE_AC_HOME
  AC_BACK = SDL2::Input::Keyboard::SDL_SCANCODE_AC_BACK
  AC_FORWARD = SDL2::Input::Keyboard::SDL_SCANCODE_AC_FORWARD
  AC_STOP = SDL2::Input::Keyboard::SDL_SCANCODE_AC_STOP
  AC_REFRESH = SDL2::Input::Keyboard::SDL_SCANCODE_AC_REFRESH
  AC_BOOKMARKS = SDL2::Input::Keyboard::SDL_SCANCODE_AC_BOOKMARKS
  BRIGHTNESSDOWN = SDL2::Input::Keyboard::SDL_SCANCODE_BRIGHTNESSDOWN
  BRIGHTNESSUP = SDL2::Input::Keyboard::SDL_SCANCODE_BRIGHTNESSUP
  DISPLAYSWITCH = SDL2::Input::Keyboard::SDL_SCANCODE_DISPLAYSWITCH
  KBDILLUMTOGGLE = SDL2::Input::Keyboard::SDL_SCANCODE_KBDILLUMTOGGLE
  KBDILLUMDOWN = SDL2::Input::Keyboard::SDL_SCANCODE_KBDILLUMDOWN
  KBDILLUMUP = SDL2::Input::Keyboard::SDL_SCANCODE_KBDILLUMUP
  EJECT = SDL2::Input::Keyboard::SDL_SCANCODE_EJECT
  SLEEP = SDL2::Input::Keyboard::SDL_SCANCODE_SLEEP
  APP1 = SDL2::Input::Keyboard::SDL_SCANCODE_APP1
  APP2 = SDL2::Input::Keyboard::SDL_SCANCODE_APP2
end
