Shoes.app :width => 400, :height => 700, :title => "Math-a-Cora" do

  # App setup

  @name = ask "What's Your Name?"
  stack :align => "center" do
    para "Hello #{@name}!", :align => "center", :size => "xx-large"
    @the_problem = para "", :align => "center", :size => "x-large"
    @the_answer = "into the void..."
    @the_entry = edit_line "", :width => 390
  end
      
  stack :align => "center" do
    @the_entry.change do |entry|
      solved! if @the_entry.text == @the_answer
    end
  end
  
  @new_problem = button "Try Another" do |btn|
    new_problem
  end
  
  @image = image :align => "center", :width => 380, :margin_left => "10px"
  
  # Helpers

  def new_problem
    @the_problem.text = "#{rand(5) + 1} + #{rand(5) + 1}"
    @the_problem.stroke = black

    @the_answer = eval(@the_problem.text).to_s
    
    @the_entry.text = ""
    
    @image.path = ""
  end

  def solved!
    @the_problem.stroke = green
    @image.path = File.expand_path("~/.hacketyhack/pics/cora.jpg")
  end
  
  # Startup
  new_problem
end