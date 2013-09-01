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

  MOVES = {
    :up    => [-10, nil],
    :down  => [10, nil],
    :left  => [nil, -10],
    :right => [nil, 10],

    :shift_up    => [-40, nil],
    :shift_down  => [40, nil],
    :shift_left  => [nil, -40],
    :shift_right => [nil, 40],
  }
  def keypress(key)
    move = MOVES[key]
    
    if move != nil
      princess.top  += move[0] unless move[0].nil?
      princess.left += move[1] unless move[1].nil?
    elsif key == " " && can_act?
      act!
    else
      alert "wat? #{key.inspect}"    
    end
    
    if can_act?
      highlight_princess
    else
      unhighlight_princess
    end

  end
  
  def highlight_princess
    @princess.path = @princess.path.gsub("princess.jpg", "princess.highlight.jpg")
  end

  def unhighlight_princess
    @princess.path = @princess.path.gsub("princess.highlight.jpg", "princess.jpg")
  end  
  
  def can_act?
    false
  end

  def method_missing(meth, *args, &block)
    @app.send(meth, *args, &block)
  end
end

class Outside < Room  
  def setup_room
    @name = "outside"
    @app.background lightgreen
    @castle = image :left => 0, :top => self.height - 400, :height => 400, :width => self.width
    @castle.path = File.expand_path("~/.hacketyhack/princess/castle.jpg")

    @princess = image :left => 0, :top => 0, :width => 100
    @princess.path = File.expand_path("~/.hacketyhack/princess/princess.jpg")    
  end
   
  def can_act?
    princess.left >= 610 && princess.left < 610 + princess.width &&
      princess.top >= 520 && princess.top < princess.top + princess.height
  end
  
  def act!
    Room.show("inside")
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
  
  def can_act?
    attack_dog? || in_door?
  end

  def attack_dog?
    (princess.left + princess.width) >= @dog.left && !@dog.hidden
  end
  
  def in_door?
    @door != nil && princess.left + princess.width > @door.left
  end
  
  def act!
    if attack_dog?
      @dog.path = @dog.path.gsub("dog.jpg", "dog.dead.jpg")
      timer 1 do
        @dog.hide
        @door = rect(:fill => blue, :left => @app.width - 150, :top => 420, :width => 100, :height => 250)
      end
    elsif in_door?
      Room.show("outside")
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