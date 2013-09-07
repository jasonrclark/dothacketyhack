require './princess/room'
require './princess/outside'
require './princess/inside'

class ThroneRoom < Room
  def setup_room
    @name = "throne"
    @princess = image :left => 110, :top => @app.height - 300, :width => 100
    @princess.path = File.expand_path("~/.hacketyhack/princess/princess.jpg")

    @king = image :left => 650, :top => @app.height - 300, :width => 100, :height => 180
    @king.path = File.expand_path("~/.hacketyhack/princess/king.jpg")

    @queen = image :left => 800, :top => @app.height - 300, :width => 100
    @queen.path = File.expand_path("~/.hacketyhack/princess/queen.jpg")

    @door = rect :fill => blue, :left => 10, :top => 420, :width => 100, :height => 250
    rect :fill => red, :left => 0, :top => 670, :width => @app.width
  end

  def can_act?
    in_door?
  end

  def in_door?
    princess.left < (@door.left + @door.width)
  end

  def act!
    if in_door?
      Room.show("inside")
    end
  end
end


Shoes.app :width => 1000, :height => 800 do
  Room.list.clear
  @outside = Outside.new(self)
  @inside = Inside.new(self)
  @throne = ThroneRoom.new(self)
  Room.show("outside")

  keypress do |key|
    Room.current.keypress(key)
  end
end
