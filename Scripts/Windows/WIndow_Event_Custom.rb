class Window_Custom_Event < Window_Custom

  def initialize(event, width)
    super(event.x * 72 + 36, event.y * 72 + 36, width, fitting_height(1))
  end



end