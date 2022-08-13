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
    direction_vectors = [
      { row: 0, col: 1 },
      { row: 1, col: 0 },
      { row: 1, col: 1 },
      { row: 1, col: -1 }
    ]

    (0..5).each do |row|
      (0..6).each do |column|
        direction_vectors.each do |direction|
          line = line_for(row, column, direction)
          return true if line.all? { |token| token == player_token }
        end
      end
    end
    false
  end

  def line_for(row, column, direction)
    [state.dig(column, row),
     state.dig(column + 1 * direction[:col], row + 1 * direction[:row]),
     state.dig(column + 2 * direction[:col], row + 2 * direction[:row]),
     state.dig(column + 3 * direction[:col], row + 3 * direction[:row])]
  end
end
