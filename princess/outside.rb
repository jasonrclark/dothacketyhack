class Outside < Room
  def setup_room
    @name = "outside"
    @app.background lightgreen
    @castle = image :left => 0, :top => self.height - 400, :height => 400, :width => self.width
    @castle.path = File.expand_path("~/.hacketyhack/princess/castle.jpg")

    @princess = image :left => 0, :top => 0, :width => 100
    @princess.path = File.expand_path("~/.hacketyhack/princess/princess.jpg")
  end

  def can_act?
    princess.left >= 610 && princess.left < 610 + princess.width &&
      princess.top >= 520 && princess.top < princess.top + princess.height
  end

  def act!
    Room.show("inside")
  end
end

