require './shapes'

Shoes.app do
  @back = stack do
    rect 100, 100, 180, 299, :fill => gold
    para "Love Mama!", :left => 108, :top => 150
  end

  stack(:width => 180) do
    @front = rect 100, 100, 180, 299, :fill => gold
    @heart = heart 108, 108, :width => 108
  end

  #@back.hide
  
  click do
    loop do
      @front.width -= 1
      if @front.width == 0
        @heart.hide
        sleep(0.25)
        break
      end
    end
  end
end