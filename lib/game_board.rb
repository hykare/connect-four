class GameBoard
  attr_reader :state

  def initialize(state = Array.new(7) { [] })
    @state = state
  end

  def update(value, column)
    state[column].push(value)
  end

  def draw
    top_row = "┏╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┓\n"
    bottom_row = "┗━━━━┻━━━━┻━━━━┻━━━━┻━━━━┻━━━━┻━━━━┛\n"
    separator_row = "┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫\n"
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
  end

  def full?
    state.all? { |row| row.length == 6 }
  end
end
