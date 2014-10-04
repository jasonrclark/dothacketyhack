WAIT = 5
LETTERS = ('a'..'z').to_a #+ ('A'..'Z').to_a

Shoes.app(height: 180, width: 150) do
  @background = background white
  @letter = para LETTERS.sample, left: 10, size: 100

  keypress do |key|
    if key == @letter.text
      yeah
    else
      oops
    end
  end
  
  every(WAIT) do
    oops if @letter.stroke != green
    
    @letter.stroke = black
    @letter.text = LETTERS.sample
  end
  
  def yeah
   @letter.stroke = green
   Thread.new { `afplay /System/Library/Sounds/Glass.aiff` }
  end
  
  def oops
    @letter.stroke = red
    Thread.new { `afplay ~/.hacketyhack/beep.mp3` }
  end  
end