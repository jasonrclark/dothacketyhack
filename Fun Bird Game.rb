Shoes.app width: 1500, height: 800 do
  background white
    
  # Ground
  rect 0, 750, 2000, 800, fill: darkgoldenrod
  rect 0, 720, 2000, 40, fill: chartreuse
  
  # Slingshot
  arc 150, 400, 200,  200, 0, 3.14, fill: white, strokewidth: 6
  line 160,500,160,720, strokewidth: 6
  line 53,400,100,301
  line 250,400,245,350
  
  # Piggie
  @piggie = []
  @piggie << oval(1200,600,120,120, fill: greenyellow)
  @piggie << oval(1240,650,40,40, fill: green)
  @piggie << para('0   o', left: 1240, top: 620)
  @piggie << para('o   O', left: 1240, top: 650)
  
  # Shelter
  @shelter = []
  @shelter << rect(1100, 520, 300, 30, fill: brown)
  @shelter << rect(1150, 550, 30, 170, fill: brown)
  @shelter << rect(1350, 550, 30, 170, fill: brown)
    
  # Bird
  @bird = []
  @bird << oval(70,   70,  308, 275,   fill: red   )
  @bird << para('o   O', left: 70, top: 150)
  @bird << para('<',     left: 70, top: 200, size:99, stroke: gold)
  
  # Hurray!
  @hurray = title("HURRAY!!!!", left: 600, top: 200).hide

  def move_bird
    @bird.each do |piece|
      piece.left += @increment_x
      piece.top  += @increment_y
    end
    
    if bird_hit_piggie?
      hide(@piggie)
      @hurray.show
    else
      hide(@shelter) if bird_hit_shelter?
      timer(0.7) do
        move_bird
      end unless bird_outside?
    end
    
  end
  
  def hide(things)
    things.each do |thing|
      thing.hide
    end
  end

  def bird_hit_shelter?
    bird_hit?(1150, 550)
  end
  
  def bird_hit_piggie?
    bird_hit?(1250, 600)
  end
  
  def bird_outside?    
    b = @bird.first
    (b.top + b.height) > 800 || (b.left + b.width) > 1500
  end
  
  def bird_hit?(x, y)
    b = @bird.first
    (b.top + b.height) > y && (b.left + b.width) > x
  end
        
  click do |_, x, y|
    @x = x
    @y = y
    @increment_x = (@x - 345) / 80
    @increment_y = (@y - 345) / 80
    move_bird
  end
end