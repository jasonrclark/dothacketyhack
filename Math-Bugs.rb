Shoes.app do
  @worms = []
  @worms << [oval(100, 100, 300, 40, fill: lightcoral), 2,2]
  @worms << [oval(90,  200, 300, 40, fill: magenta), 3, 3]
  @worms << [oval(100, 300, 300, 40, fill: navy), 4, 4]
  
  line 110, 112, 110, 120
  line 135, 107, 135, 120
  line 160, 103, 160, 120

  @worms.each_with_index do |worm, index|
    worm << para("#{worm[-1]}+#{worm[-2]}=", left: 200, top: (100 * (index + 1) + 10), stroke: white)
  end

  def reset
    @worms.each do |worm|
      worm.last.text = worm.last.text[0..-2]
    end
    set_current_worm(0)
  end
  
  def set_current_worm(index)
    @worms.each do |worm|
      worm[0].stroke = black
    end
    if @worms[index]
      @worms[index][0].stroke = red
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
        set_current_worm(@current_worm + 1)
        if @worms[@current_worm].nil?
          alert "Hurray!"
          reset
        end
      end
    end
  end  
end