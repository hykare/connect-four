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
    offsets = [
      { row: 0, col: 1 },
      { row: 1, col: 0 },
      { row: 1, col: 1 },
      { row: 1, col: -1 }
    ]

    (0..5).each do |row|
      (0..6).each do |column|
        offsets.each do |offset|
          line = [state.dig(column, row),
                  state.dig(column + 1 * offset[:col], row + 1 * offset[:row]),
                  state.dig(column + 2 * offset[:col], row + 2 * offset[:row]),
                  state.dig(column + 3 * offset[:col], row + 3 * offset[:row])]

          return true if line.all? { |token| token == player_token }
        end
      end
    end
    false
  end
end
