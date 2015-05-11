Shoes.app do
  # Worms!
  @worms = []
  @worms << [oval(200, 100, 300, 40, fill: lightcoral), 2,2, para("")]
  @worms << [oval(200, 200, 300, 40, fill: magenta), 3, 3, para("")]
  @worms << [oval(200, 300, 300, 40, fill: navy), 4, 4, para("")]
  
  @worms.each_with_index do |worm, index|
    p = worm.last
    p.text = "#{worm[-2]}+#{worm[-3]}="
    p.left = 300
    p.top =  (100 * (index + 1) + 10)
    p.stroke = white
    p.hide
  end
  
  # Finish Line!
  3.times do |i|
    rect 0, 90 * (2 * i), 90, 90, fill: red
    rect 0, 90 * (2 * i + 1), 90, 90 , fill: darkblue
  end

  # Helpers
  def reset
    @worms.each do |worm|
      worm.last.text = worm.last.text[0..-2]
    end
    set_current_worm(0)
  end
  
  def reset_problem(index)
    i = rand(9)
    j = rand(10-i)

    worm = @worms[index]
    worm[-2] = i
    worm[-3] = j
    worm.last.text = "#{worm[-2]}+#{worm[-3]}="
  end
  
  def set_current_worm(index)
    index = index % @worms.length
    @worms.each do |worm|
      worm.last.hide
    end

    if worm = @worms[index]
      worm.last.toggle
    end
    
    @current_worm = index
  end

  set_current_worm(0)      

  keypress do |key|
    worm = @worms[@current_worm]
    if worm
      if key.is_a?(String)
        worm.last.text = worm.last.text.gsub(/=.*/, "=#{key}") 
      end 

      if key == (worm[-2] + worm[-3]).to_s
        worm.each do |element|
          element.left -= 20 unless element.is_a?(Integer)
        end  
      else
        Thread.new { `afplay ~/.hacketyhack/beep.mp3` }
      end

      reset_problem(@current_worm)      
      set_current_worm(@current_worm + 1)
    end
  end  
end