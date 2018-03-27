
class Bi::Action::Callback < Bi::Action::Base
  def initialize(&callback)
    super(0,&callback)
  end
end
