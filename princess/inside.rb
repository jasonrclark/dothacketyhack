class Inside < Room
  def setup_room
    @name = "inside"
    @princess = image :left => 0, :top => @app.height - 300, :width => 100
    @princess.path = File.expand_path("~/.hacketyhack/princess/princess.jpg")

    @dog = image :right => 0, :top => @app.height - 270, :width => 250
    @dog.path = File.expand_path("~/.hacketyhack/princess/dog.jpg")

    rect :fill => brown, :left => 0, :top => 670, :width => @app.width
  end

  def showing
    if @dog.hidden
      @door.show
    end
  end

  def can_act?
    attack_dog? || in_door?
  end

  def attack_dog?
    (princess.left + princess.width) >= @dog.left && !@dog.hidden
  end

  def in_door?
    @door != nil && princess.left + princess.width > @door.left
  end

  def act!
    if attack_dog?
      @dog.path = @dog.path.gsub("dog.jpg", "dog.dead.jpg")
      timer 1 do
        @dog.hide
        @door = rect(:fill => blue, :left => @app.width - 150, :top => 420, :width => 100, :height => 250)
      end
    elsif in_door?
      @door.hide
      Room.show("throne")
    end
  end
end
