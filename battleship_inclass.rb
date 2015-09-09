#RUTI

# def place(x, y, across)
#   @across = across
#   @x = x
#   @y = y
# end
#
# def covers?
#   @across ? (@x..@x+@length).include?(x) && @y == y : (@y..@y+@length).include?(y) && @x == x
# end

#MASON & GANG
# 
# def initialize(length)
#   @length = length
#   @positions = []
# end

def place(x, y, across)
  return false unless @positions.empty?
  if across
    (x...x+length).each do |i|
      @positions << [i, y]
    end
  else
    (y...y+length).each do |i|
      @positions << [x, i]
    end
  end
  true
end

def covers?(x, y)
  @positions.include?([x, y])
end

def overlaps_with?(other_ship)
  @positions.each do |place|
    return true if other_ship.covers?(place[0], place[1])
  end
  false
end

def fire_at(x, y)
  if covers?(x, y) && !hits.include?([x, y])
    @hits << [x, y]
  end
end

def sunk?
  if @hits.length >= @length
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
    empty_grid
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
