is_across = true
i = 0
x = 2
y = 1
ship = 4
@pos = []

class Position
  def initialize(x, y)
    @posx = x
    @posy = y
    @hit = 0
  end

  def posx
    @posx
  end

  def posy
    @posy
  end

  def hit
    @hit
  end
end

if is_across
  until ship == i do
    @pos[x] = Position.new(x, y)
    i += 1
    x += 1
  end
else
  until ship == i do
    @pos[y] = Position.new(x, y)
    i += 1
    x += 1
  end
end
# if @pos.length == self.length
#   puts true
# end

puts @pos.posx
