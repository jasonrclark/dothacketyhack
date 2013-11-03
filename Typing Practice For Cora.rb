WORDS = [
  "cora",
  "mom",
  "dad",
  "asher",
  "josie",
  "cat",
  "dog",
  "FLOWER",
  "brusier"
  ].map do |word|
  [word.downcase, word.upcase, word.capitalize]
end.flatten

Shoes.app :width => 400, :height => 800, :title => "Typing Practice" do

  # App setup

  @name = ask "What's Your Name?"
  stack :align => "center" do
    para "Hello #{@name}!", :align => "center", :size => "xx-large"
    @the_entry = edit_line "", :width => 390
  end
      
  para ""
  @the_word = para ""
  
  stack :align => "center" do
    @the_entry.change do |entry|
      highlight_word if @the_word.text == entry.text
    end
  end

  button "Pick a Word!", :margin_left => "65%" do |btn|
    new_word
  end.focus
  
  button "New Word!", :margin_left => "65%" do
    new_word(ask "What's Another Word?")
  end
  
  @image = image :align => "center", :width => 380, :margin_left => "10px"
  
  # Helpers
  
  def new_word(word=nil)
    word ||= pick_a_word
    @the_word.text = word
    
    reset_word
    reset_entry
  end
      
  def pick_a_word
    WORDS[rand(WORDS.length)]
  end
  
  def highlight_word
    @the_word.stroke = green
    @the_word.size = "xx-large"
    
    path = "~/.hacketyhack/pics/#{@the_word.text.downcase}.jpg"
    @image.path = File.expand_path(path)
  end
  
  def reset_word
    @the_word.stroke = black
    @the_word.size = "medium"
    
    @image.path = ""
  end

  def reset_entry
    @the_entry.text = ""
    @the_entry.focus
  end
  
end