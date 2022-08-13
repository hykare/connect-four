require_relative 'position'
require_relative 'direction'

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
    Direction.all do |direction|
      each_position do |position|
        line = line_for(position, direction)
        return true if line.all? { |token| token == player_token }
      end
    end
    false
  end

  def each_position
    (0..5).each do |row|
      (0..6).each do |column|
        yield Position.new(row, column)
      end
    end
  end

  def line_for(position, direction)
    row = position.row
    column = position.column
    [state.dig(column + 0 * direction.column, row + 0 * direction.row),
     state.dig(column + 1 * direction.column, row + 1 * direction.row),
     state.dig(column + 2 * direction.column, row + 2 * direction.row),
     state.dig(column + 3 * direction.column, row + 3 * direction.row)]
  end
end
