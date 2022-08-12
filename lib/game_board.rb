class GameBoard
  attr_reader :state

  def initialize(state = Array.new(7) { [] })
    @state = state
  end

  def update(token, column)
    state[column].push(token)
  end

  def draw
    top_row = "┏╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┓\n"
    bottom_row = "┗━━━━┻━━━━┻━━━━┻━━━━┻━━━━┻━━━━┻━━━━┛\n"
    separator_row = "┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫\n"
    column_numbers = "  1    2    3    4    5    6    7\n"
    token_rows = []

    5.downto(0) do |row|
      token_row = ""
      0.upto(6) do |column|
        token = state[column][row]

        token_row << "┃ "
        token_row << (token.nil? ? "  " : token)
        token_row << " "
      end
      token_row << "┃\n"
      token_rows.push(token_row)
    end

    print top_row
    print token_rows.join(separator_row)
    print bottom_row
    print column_numbers
  end

  def full?
    state.all? { |row| row.length == 6 }
  end

  def win?(player_token)
    # horizontal
    (0..5).each do |row|
      (0..3).each do |column|
        line = [state[column][row], state[column + 1][row], state[column + 2][row], state[column + 3][row]]
        return true if line.all? { |token| token == player_token }
      end
    end
    # vertical
    (0..6).each do |column|
      (0..2).each do |row|
        line = [state[column][row], state[column][row + 1], state[column][row + 2], state[column][row + 3]]
        return true if line.all? { |token| token == player_token }
      end
    end
    # diagonal-right
    (0..3).each do |column|
      (0..2).each do |row|
        line = [state[column][row], state[column + 1][row + 1], state[column + 2][row + 2], state[column + 3][row + 3]]
        return true if line.all? { |token| token == player_token }
      end
    end
    # diagonal-left
    (3..6).each do |column|
      (0..2).each do |row|
        line = [state[column][row], state[column - 1][row + 1], state[column - 2][row + 2], state[column - 3][row + 3]]
        return true if line.all? { |token| token == player_token }
      end
    end
    false
  end
end
