Shoes.app do
  # oval 40, 200, 200, 60, :stroke => green, :fill => indigo
  # oval 256, 98, 56, 432, :fill => springgreen, :stroke => slategray
  # oval 89, 66, 80, 12, :fill => deeppink
  # star 320, 98,100, :fill => fuchsia, :stroke => white
  
  @left = 10
  def set_timer
    timer 0.999 do
      oval @left, 20, 18, 18, :stroke => deeppink, :fill => darkviolet
      oval @left, 100, 18, 18, :stroke => black, :fill => white
      oval @left, 70, 18, 18,   :stroke => white,  :fill =>red
      oval @left, 130, 18, 18, :stroke => saddlebrown, :fill => springgreen
      oval @left, 160, 18, 18, :stroke => magenta, :fill => lime
      oval @left, 190, 18, 18, :stroke => blueviolet, :fill => aquamarine
      
      @left += 10
 
      sleep 0.3
      set_timer   
    end  
  end
  
  set_timer
end