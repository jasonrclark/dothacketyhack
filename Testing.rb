class Room
  def initialize(app)
    @app = app
    @stack = stack do
      para "Room"
      @button = button("Bo") {@stack.hide}
    end
  end
  
  def method_missing(meth, *args, &block)
    @app.send(meth, *args, &block)
  end
end

Shoes.app do
  Room.new(app)
  #@app = self
  #@stack = stack do
  #  para "Boo"
  #end
  
  #@stack.append do
  #  @app.button("Bo") { @stack.hide }
  #end
end