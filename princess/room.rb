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

  def showing
    # Hook for rooms to override when they're being shown
  end

  def show
    self.showing
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

