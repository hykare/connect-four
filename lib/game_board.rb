class GameBoard
  attr_reader :state

  def initialize(state = Array.new(7) { [] })
    @state = state
  end

  def update(value, column)
    state[column].push(value)
  end
end
