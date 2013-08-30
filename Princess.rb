class Room
  attr_reader :princess

  def self.current
    @current
  end
  
  def self.current=(room)
    @current = room
  end
 
  def initialize(app)
    @app = app
    @background ||= white
    @stack = stack :left => @app.width * 10, :top => 0 do
      setup_room
    end
  end

  def setup_room
    # Expects subclasses to fill in
    para "Create me a room by filling in the setup_room method"
  end

  def show
    @stack.left = 0
    Room.current = self
  end
  
  def hide
    @stack.hide
  end

  def method_missing(meth, *args, &block)
    @app.send(meth, *args, &block)
  end
end

class Outside < Room  
  def setup_room
    @castle = image :left => 0, :top => self.height - 400, :height => 400, :width => self.width
    @castle.path = File.expand_path("~/.hacketyhack/princess/castle.jpg")

    @princess = image :left => 0, :top => 0, :width => 100
    @princess.path = File.expand_path("~/.hacketyhack/princess/princess.jpg")
  end
end

Shoes.app :width => 1000, :height => 800 do
  @outside = Outside.new(self)
  @outside.show
  
  keypress do |key|
    case key
    when :up
      Room.current.princess.top -= 10
    when :down
      Room.current.princess.top += 10
    when :right
      Room.current.princess.left += 10
    when :left
      Room.current.princess.left -= 10
    else
     alert "wat? #{key.inspect}"
    end
  end
end