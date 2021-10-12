class Triangle

  @@all = []

  def self.all
    @@all
  end

  attr_accessor :side_1, :side_2, :side_3, :triangle_definition, :size

  def initialize(side_1, side_2, side_3)
    self.triangle_definition = [self.side_1 = side_1, self.side_2 = side_2, self.side_3 = side_3]
    self.save if self.unique?
  end

  def save
    self.class.all << self.triangle_definition
  end

  def unique?
    !self.class.all.include?(self.triangle_definition) ? true : false
  end

  def follow_triangle_inequality?
    if self.side_1 + self.side_2 > self.side_3
      if self.side_1 + self.side_3 > self.side_2
        if self.side_2 + self.side_3 > self.side_1
          true
        end
      end
    else
      false
    end
  end

  def invalid?
    self.triangle_definition.any?{|i|i < 0}
  end

  def kind
    raise TriangleError if self.invalid? || !self.follow_triangle_inequality?
    self.size = self.triangle_definition.uniq.length
    case self.size
    when 1
      return :equilateral
    when 2
      return :isosceles
    when 3
      return :scalene
    end
  end

  class TriangleError < StandardError
  end

end
