class Direction
  attr_reader :row, :column

  def initialize(row, column)
    @row = row
    @column = column
  end

  def self.all(&block)
    up = Direction.new(1, 0)
    right = Direction.new(0, 1)
    up_right = Direction.new(1, 1)
    up_left = Direction.new(1, -1)
    [up, right, up_right, up_left].each(&block)
  end
end