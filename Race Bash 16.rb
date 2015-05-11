class Car
  def initialize(app, x, y, color, keys)
    @pieces = []
    @pieces << app.rect(x,       y,       100, 200, fill: color)
    @pieces << app.oval(x,       y,       6, 30, fill: app.black)
    @pieces << app.oval(x + 100, y,       6, 30, fill: app.black)
    @pieces << app.oval(x,       y + 170, 6, 30, fill: app.black)
    @pieces << app.oval(x + 100, y + 170, 6, 30, fill: app.black)
    
    @direction = [0,0]
    @keys = keys
    @app  = app
  end

  SPEED = 5
  
  def on_keypress(key)
    case key
    when @keys[0] then @direction[1] -= SPEED
    when @keys[1] then @direction[1] += SPEED
    when @keys[2] then @direction[0] -= SPEED
    when @keys[3] then @direction[0] += SPEED
    when @keys[4] then @direction = [0, 0]
    end
  end
  
  def tick
    up = @pieces.all? do |piece|
      proposed_y = piece.top + @direction[1]
      proposed_y > 0 && proposed_y < @app.height - piece.height
    end
    
    side = @pieces.all? do |piece|
      proposed_x = piece.left + @direction[0]
      proposed_x > 0 && proposed_x < @app.width - piece.width
    end
    
    @pieces.each do |piece|
      piece.left += @direction[0] if side
      piece.top  += @direction[1] if up
    end
  end
end

Shoes.app width: 1200, height: 800 do
  background green
    
  oval 0, 0, 1200, 800, fill: gray
  oval 200, 200, 800, 400, fill: green
  
  cars = [
    Car.new(self, 100, 100, blue, [:up, :down, :left, :right, "\n"]),
    Car.new(self, 1000, 500, red, ["w", "s", "a", "d", " "])
  ]
  
  SPEED = 5
  direction = [0, 0]
  keypress do |key|
    cars.each do |car|
      car.on_keypress(key)
    end
  end
  
  animate 10 do
    cars.each do |car|
      car.tick
    end
  end  
end