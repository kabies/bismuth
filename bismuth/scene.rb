
class Bi::Scene < Bi::Node
  def initialize()
    super()
    self.a = 0xFF
    self.w = Bi::Window.w
    self.h = Bi::Window.h
  end
end
