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
    @hit = false
  end

  def hit?
    @hit
  end

  # if @hit is true, return false so that the program knows that we have already hit this location.  Otherwise set @hit to true.
  def hit!
    if @hit
      return false
    else
      @hit = true
    end
  end
end

class Ship
  attr_reader :length, :positions, :hits

  def initialize(length)
    @length = length
    @positions = []
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
    # For each Position object in the positions array, check to see if the x and y objects equal any positions listed there.
    @positions.each do |place|
      return place if place.x == x && place.y == y
    end
    false
  end

  def overlaps_with?(other_ship)
    # Check positions and return true if any of other_ship's coordinates are already inside positions.
    @positions.any? {|p| other_ship.covers?(p.x, p.y)}
  end

  def fire_at(x, y)
    # Check to see if x and y are covered in any existing Position objects and whether hits has a record of a hit.
    # Set hit on Position object if one is not already recorded.
    position = covers?(x, y)
    position && position.hit!
  end

  def hit_on?(x, y)
    # Check to see if x and y are covered in any existing Position objects and if there is a hit recorded.
    position = covers?(x, y)
    position && position.hit?
  end

  def sunk?
    # Sink ship if hits are greater than or equal to the length of the ship.
    !@positions.empty? && @positions.all? {|p| p.hit?}
  end
end

class Grid
  attr_reader :ships, :hits

  def initialize
    @ships = []
    @hits = []
  end

  def has_ship_on?(x, y)
    @ships.each do |ship|
      return ship if ship.covers?(x, y)
    end
    false
  end

  def place_ship(ship, x, y, across)
    ship.place(x, y, across)
    unless @ships.any?{|s| ship.overlaps_with?(s)}
      @ships << ship
    else
      false
    end
  end

  def fire_at(x, y)
    ship = has_ship_on?(x, y)
    if ship
      ship.fire_at(x, y)
    else
      false
    end
  end

  def display
    e_coord = "   |"
    o_coord = " O |"
    h_coord = " X |"
    left_col = ["A |", "B |", "C |", "D |", "E |", "F |", "G |", "H |", "I |", "J |"]
    puts "    1   2   3   4   5   6   7   8   9   10"
    print "  -----------------------------------------"
    10.times do |a|
      print "\n"
      print left_col[a]
      10.times do |b|
        if has_ship_on?(b+1, a+1) && @ships.any?{ |s| s.hit_on?(b+1, a+1) }
          print h_coord
        elsif has_ship_on?(b+1, a+1)
          print o_coord
        else
          print e_coord
        end
      end
    end
    puts "\n  -----------------------------------------"
  end

  def sunk?
    return
  end
end


# CHECKING THE BREAKDOWN OF OBJECTS WITHIN EACH SHIP
# i = 0
# battleship = Ship.new(4)
# battleship.place(2, 1, true)
# # puts battleship.positions[0].x
# #
# # puts "#{battleship.positions[1].x}, #{battleship.positions[1].y}"
# # puts battleship.positions[2]
# # puts battleship.positions
# puts battleship.positions[0].x
# puts battleship.positions[0].y
