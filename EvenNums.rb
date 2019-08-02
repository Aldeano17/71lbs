class EvenNums
  def initialize(*args)
    @array = *args
  end

  def Evens
    @evensArray = []
    @array.each{ |num|
    remainder = num % 2
      if remainder == 0
        @evensArray.push num
      end
    }
    return @evensArray
  end
end

evenNums = EvenNums.new(2.3, 6.0, 1.23, 4.0, 6.00, 7.2, 8.0)
puts evenNums.Evens