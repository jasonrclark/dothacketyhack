Shoes.app do
  background green
  @p = para "", :background => red #, :stroke => purple

  keypress do |k|
    if k == :backspace
      @p.text = @p.text[0..-2]
    else
      @p.text += k
    end
  end
end
