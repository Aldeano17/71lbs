# thePower = 3**2

class CalculateThePower
  def initialize(x, y)
    @x = x
    @y = y
  end

  def toThePower
    @power = @x ** @y
    return @power
  end
end

@thePower = CalculateThePower.new(40, 2)
puts @thePower.toThePower