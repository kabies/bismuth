
class Bi::Action::Remove < Bi::Action::Base

  def initialize(&callback)
    super(0,&callback)
  end

  def progress(rate)
    if rate >= 1.0
      @node.remove_from_parent
    end
    super rate
  end
end
