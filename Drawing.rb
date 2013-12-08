Shoes.app do
  @left = 10
  def set_timer
    timer 0.999 do
      oval @left, 20, 802, 567, :stroke => deeppink, :fill => darkviolet
      oval @left, 100, 18, 18, :stroke => black, :fill => white
      oval @left, 70, 18, 18,   :stroke => white,  :fill =>red
      oval @left, 130, 18, 18, :stroke => saddlebrown, :fill => springgreen
      oval @left, 160, 18, 18, :stroke => magenta, :fill => lime
      oval @left, 190, 802, 567, :stroke => blueviolet, :fill => aquamarine
      oval @left, 320, 802, 567,  :stroke => darkviolet, :fill => fuchsia 
      @left += 10
 
      sleep 0.3
      set_timer   
    end  
  end
  
  set_timer
end