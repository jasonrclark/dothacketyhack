class Room
  attr_reader :princess, :name

  def self.current
    @current
  end
  
  def self.current=(room)
    @current = room
  end
  
  def self.list
    @list ||= []
  end
  
  def self.by_name(name)
    list.find { |room| room.name == name }
  end
  
  def self.show(name)
    list.select{ |room| room.name != name }.each { |room| room.hide }
    by_name(name).show
  end
 
  def initialize(app)
    @app = app
    @background ||= white
    @stack = stack :height => 0, :top => 0, :background => lightblue do
      setup_room
    end
    Room.list << self
  end

  def setup_room
    # Expects subclasses to fill in
    para "Create me a room by filling in the setup_room method"
  end

  def show
    @stack.height = @app.height
    Room.current = self
  end
  
  def hide
    @stack.height = 0
  end

  def keypress(key)
    case key
    when :up
      princess.top -= 10
    when :down
      princess.top += 10
    when :right
      princess.left += 10
    when :left
      princess.left -= 10
    else
     alert "wat? #{key.inspect}"
    end
  end

  def method_missing(meth, *args, &block)
    @app.send(meth, *args, &block)
  end
end

class Outside < Room  
  def setup_room
    @name = "outside"
    @castle = image :left => 0, :top => self.height - 400, :height => 400, :width => self.width
    @castle.path = File.expand_path("~/.hacketyhack/princess/castle.jpg")

    @princess = image :left => 0, :top => 0, :width => 100
    @princess.path = File.expand_path("~/.hacketyhack/princess/princess.jpg")
  end
  
  def keypress(key)
    if key == " " && princess_in_the_doorway
      Room.show("inside")
    else
      super(key)
    end    
  end
    
  def princess_in_the_doorway
    princess.left >= 610 && princess.left < 610 + princess.width &&
      princess.top >= 520 && princess.top < princess.top + princess.height
  end
end

class Inside < Room
  def setup_room
    @name = "inside"
    @princess = image :left => 0, :top => @app.height - 300, :width => 100
    @princess.path = File.expand_path("~/.hacketyhack/princess/princess.jpg")
    
    @dog = image :right => 0, :top => @app.height - 270, :width => 250
    @dog.path = File.expand_path("~/.hacketyhack/princess/dog.jpg")
    
    rect :fill => brown, :left => 0, :top => 670, :width => @app.width
  end
  
  def keypress(key)
    case key
    when " "
      Room.show("outside")
    else
      super(key)
    end
  end
end

Shoes.app :width => 1000, :height => 800 do
  Room.list.clear
  @outside = Outside.new(self)
  @inside = Inside.new(self)
  Room.show("outside")
  
  keypress do |key|
    Room.current.keypress(key)
  end
end