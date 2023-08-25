class Window_Custom < Window_Base

  def initialize(x, y, width, height)
    super
    @@x = x
    @@y = y
    @@width = width
    @@height = height
    self.windowskin = Cache.system("System")
  end
  def call(message, waitt)
    @@width = @@width - 5
    @@height = @@height - 5
    draw_text(@@x, @@y, @@width, @@height, message)
    wait waitt
  end

  def wait(duration)
    duration.times { Fiber.yield }
  end
end