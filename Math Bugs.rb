Shoes.app do
  rect 100, 100, 300, 90, fill: lightcoral
  @p = para '2+2=', left: 200, top: 150

  keypress do |key|
    if key.is_a?(String)
      @p.text = @p.text.gsub(/=.*/, "=#{key}") 
    end
    
    if key == "4"
      alert "Hurray!"
    end
  end
end