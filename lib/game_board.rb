require_relative 'position'
require_relative 'direction'

class GameBoard
  def initialize(state = Array.new(7) { [] })
    @state = state
  end

  def update(token, column)
    @state[column].push(token)
  end

  def draw
    top_row = "┏╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┓\n"
    bottom_row = "┗━━━━┻━━━━┻━━━━┻━━━━┻━━━━┻━━━━┻━━━━┛\n"
    separator_row = "┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫\n"
    column_numbers = "  1    2    3    4    5    6    7\n"
    token_rows = []

    rows_top_down do |row|
      row.map! { |token| token.nil? ? "  " : token }
      token_rows.push("┃ " + row.join(" ┃ ") + " ┃\n")
    end

    print top_row
    print token_rows.join(separator_row)
    print bottom_row
    print column_numbers
  end

  def rows_top_down
    5.downto(0) do |row|
      token_row = []
      0.upto(6) do |column|
        token_row.push(token_at(row, column))
      end
      yield token_row
    end
  end

  def token_at(row, column)
    @state.dig(column, row)
  end

  def full?
    @state.all? { |column| column.length == 6 }
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
    [token_at(position.column + 0 * direction.column, position.row + 0 * direction.row),
     token_at(position.column + 1 * direction.column, position.row + 1 * direction.row),
     token_at(position.column + 2 * direction.column, position.row + 2 * direction.row),
     token_at(position.column + 3 * direction.column, position.row + 3 * direction.row)]
  end
end
