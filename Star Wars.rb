require './shapes'

Shoes.app do
  background white
  
  # Darth Vader
  arc 100, 100, 100, 100, Shoes::PI, 0
  oval 104, 80, 10, 6, fill:aliceblue
  oval 80, 80, 10, 6, fill:aliceblue
  line 80, 90, 80, 100, stroke:white
  line 90, 90, 90, 100, stroke:white
  line 100, 90, 100, 100, stroke:white
  line 110, 90, 110, 100, stroke:white
  rect 80, 100, 40, 20
  rect 25, 120, 150, 250
  line 45, 120, 35, 400, stroke:white
  line 145, 120, 160, 400, stroke:white
  
  rect 45, 370, 30, 40
  rect 125, 370, 30, 40
  @saber1 = line 60, 220, 60, 100, displace_left: 0, strokewidth: 10, stroke:darkred, cap: :curve
  @saber2 = line 60, 220, 60, 102, displace_left: 0, strokewidth: 5, stroke:red, cap: :curve
  @fist  = oval 40, 220, 35, 30, fill:darkgray
  
  # Yoda
  @ears = []
  @ears << line(260, 150, 320, 235, strokewidth:10, stroke:red)
  @ears << line(260, 150, 320, 220, strokewidth:10, stroke:limegreen, cap: :curve)
  @ears << line(260, 150, 320, 250, strokewidth:10, stroke:limegreen, cap: :curve)
  
  @ears << line(440, 150, 380, 235, strokewidth:10, stroke:red)
  @ears << line(440, 150, 380, 220, strokewidth:10, stroke:limegreen, cap: :curve)
  @ears << line(440, 150, 380, 250, strokewidth:10, stroke:limegreen, cap: :curve)
  
  oval 300, 200, 100, 100, fill:limegreen, stroke:limegreen
  oval 320, 250, 10, 10
  oval 380, 250, 10, 10
  line 340, 220, 360, 220, stroke:aliceblue
  line 335, 230, 365, 230, stroke:aliceblue
  line 330, 240, 370, 240, stroke:aliceblue
  
  rect 300, 300, 100, 100, fill:brown, stroke:brown
  rect 340, 300, 20, 30,   fill:black
  
  oval 290, 330, 20, 20, fill:limegreen, stroke:limegreen
  oval 400, 330, 20, 20, fill:limegreen, stroke:limegreen
  
  rect 310, 400, 20, 20, fill:limegreen, stroke:limegreen
  rect 370, 400, 20, 20, fill:limegreen, stroke:limegreen
  
  keypress do |key|
    case key
    when " "
      alert @ears.first.top
    when "d"
      move_saber(10)
    when "D"
      move_saber(-10)
    when "y"
      move_ears(10)
    when "Y"
      move_ears(-10)
    end
  end
  
  def move_saber(value)
    return if (@saber1.left <= 30 && value < 0) || (@saber1.left > 180 && value > 0)
    
    @saber1.left  += value
    @saber1.right += value
      
    @saber2.left  += value
    @saber2.right += value
    
    @fist.left += value
  end
  
  def move_ears(value)  
    return if (@ears.first.top > 220 && value > 0) || (@ears.first.top <= 150 && value < 0)
    
    @ears.each do |ear|
      ear.top += value
    end
  end
end