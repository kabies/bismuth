
class Bi::Scene < Bi::Node
  def initialize()
    super()
    self.w = Bi::Window.w
    self.h = Bi::Window.h
  end
end
