class Player
  # def initialize()
  #
  # end
end

class ComputerPlayer < Player
  def name
    "HAL 9000"
  end
end

class HumanPlayer < Player
  attr_reader :name

  def initialize(name = "Dave")
    @name = name
  end
end

class Position
  attr_reader :x, :y

  # When we want to reference a Position object's coordinates, we must use ship.positions[i].x and ship.positions[i].y
  def initialize(x, y)
    @x = x
    @y = y
    @hit = 0
  end

  def is_hit
    @hit
  end
end

class Ship
  attr_reader :length, :positions, :hits

  def initialize(length)
    @length = length
    @positions = []
    @hits = []
  end

  def place(x, y, across)
    # If nothing is in positions, abort method.
    return false unless @positions.empty?
    # If across... duh this is an easy part
    if across
      # For range of x through x plus length of ship, create a new Position object and place it in the positions array.
      (x...x+length).each do |i|
        @positions << Position.new(i, y)
      end
      # And do the same thing in the other direction if across == false
    else
      (y...y+length).each do |i|
        @positions << Position.new(x, i)
      end
    end
  end

  def covers?(x, y)
    # For each object in the positions array, check to see if the x and y objects equal the current coordinate being passed in.
    @positions.each do |place|
      return place if place.x == x && place.y == y
    end
    false
  end

  def overlaps_with?(other_ship)
    # Check positions and return true if any of other_ship's coordinates are already inside positions.
    @positions.any? {|place| other_ship.covers?(place.x, place.y)}
  end

  def fire_at(x, y)
    if covers?(x, y) && !@hits.include?([x, y])
      @hits << [x, y]
    end
  end

  def sunk?
    if @hits.length >= @length
      return true
    end
    false
  end
end

class Grid
  def initialize
    @ships = []
  end

  def has_ship_on?(x, y)
    @ships.each do |ship|
      return true if ship.covers?(x, y)
    end
    false
  end

  def display
    left_col = [ "A |", "B |", "C |", "D |", "E |", "F |", "G |", "H |", "I |", "J |" ]
    puts "    1   2   3   4   5   6   7   8   9   10"
    print "  -----------------------------------------"
    10.times do |a|
      print "\n"
      print left_col[a]
      10.times do |b|
        print "   |"
      end
    end
    puts "\n  -----------------------------------------"
  end

  def empty_grid
    %Q{    1   2   3   4   5   6   7   8   9   10
  -----------------------------------------
A |   |   |   |   |   |   |   |   |   |   |
B |   |   |   |   |   |   |   |   |   |   |
C |   |   |   |   |   |   |   |   |   |   |
D |   |   |   |   |   |   |   |   |   |   |
E |   |   |   |   |   |   |   |   |   |   |
F |   |   |   |   |   |   |   |   |   |   |
G |   |   |   |   |   |   |   |   |   |   |
H |   |   |   |   |   |   |   |   |   |   |
I |   |   |   |   |   |   |   |   |   |   |
J |   |   |   |   |   |   |   |   |   |   |
  -----------------------------------------
}
  end

  def place_ship(ship, x, y, across)
    ship.place(x, y, across)
    @ships << ship
  end
end


# CHECKING THE BREAKDOWN OF OBJECTS WITHIN EACH SHIP
# i = 0
# battleship = Ship.new(4)
# battleship.place(2, 1, true)
# puts battleship.positions[0].x
#
# puts "#{battleship.positions[1].x}, #{battleship.positions[1].y}"
# puts battleship.positions[2]
# puts battleship.positions
