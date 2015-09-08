class Player
  # def initialize()
  #
  # end
end

class ComputerPlayer < Player

  attr_reader :name, :length

  def initialize(name: "HAL 9000")
    @name = name
  end

  def name()
    @name
  end
end

class HumanPlayer < Player
  def initialize(name = "Dave")
    @name = name
  end

  def name()
    @name
  end
end

class Position
  def initialize(x, y)
    @position = [x, y]
    @hit = 0
  end

  def position
    @position
  end

  def is_hit
    @hit
  end
end

class Ship
  def initialize(length)
    @length = length
  end

  def length()
    @length
  end

  def place(x, y, is_across)
    i = 0
    @positions = []
    if is_across
      until self.length == i do
        @positions[i] = Position.new(x, y)
        i += 1
        x += 1
      end
    else
      until self.length == i do
        @positions[i] = Position.new(x, y)
        i += 1
        y += 1
      end
    end
    if @positions.length == self.length
      return true
    end
  end

  def positions
    @positions
  end

  def covers?(x, y)
    check = [x, y].to_s
    position_guts = self.positions
    position_guts.to_s.include?(check)
    # @positions.include?(check)
  end

end

class Grid
  def initialize()

  end
end

ship = Ship.new(4)
ship.place(2, 1, true)
puts ship.length
# puts ship.positions
position_guts = ship.positions
puts position_guts[0].position.to_s
puts position_guts[0].is_hit
puts position_guts[1].position.to_s
puts position_guts[2].position.to_s
puts position_guts[3].position.to_s
