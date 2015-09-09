class Player
  # def initialize()
  #
  # end
end

class ComputerPlayer < Player

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
    if @positions
      return false
    end

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
  end

  def overlaps_with?(ship)
    i = 0
    ship1_breakdown = self.positions
    ship2_breakdown = ship.positions

    until ship2_breakdown.length == i
      self.covers?(ship2_breakdown[i].position.to_s)
      i += 1
  end
  end
end

class Grid
  def initialize()

  end
end

# CHECKING THE BREAKDOWN OF OBJECTS WITHIN EACH SHIP
# battleship = Ship.new(4)
# battleship.place(2, 1, true)
# puts battleship.length
# # puts ship.positions
# position_guts = battleship.positions
# puts position_guts[0].position.to_s
# puts position_guts[1].position.to_s
# puts position_guts[2].position.to_s
# puts position_guts[3].position.to_s

# CHECKING THE WAY THAT overlaps_with? NEEDS TO BEHAVE
ship1 = Ship.new(4)
ship1.place(2, 1, true)
ship2 = Ship.new(4)
ship2.place(3, 1, true)
ship3 = Ship.new(4)
ship3.place(2, 1, false)

positions_guts = ship1.positions
puts positions_guts.length
puts positions_guts[0].position.to_s
