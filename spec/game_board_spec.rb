require_relative '../lib/game_board'

describe GameBoard do
  describe '#draw' do
    context 'when the board is empty' do
      subject(:game_board) { described_class.new }
      it 'draws an empty board' do
        empty_board = <<~BOARD
          ┏╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┓
          ┃    ┃    ┃    ┃    ┃    ┃    ┃    ┃
          ┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫
          ┃    ┃    ┃    ┃    ┃    ┃    ┃    ┃
          ┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫
          ┃    ┃    ┃    ┃    ┃    ┃    ┃    ┃
          ┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫
          ┃    ┃    ┃    ┃    ┃    ┃    ┃    ┃
          ┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫
          ┃    ┃    ┃    ┃    ┃    ┃    ┃    ┃
          ┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫
          ┃    ┃    ┃    ┃    ┃    ┃    ┃    ┃
          ┗━━━━┻━━━━┻━━━━┻━━━━┻━━━━┻━━━━┻━━━━┛
        BOARD
        expect { game_board.draw }.to output(empty_board).to_stdout
      end
    end

    context 'when there are tokens in the board' do
      p1 = '🟡'
      let(:state) { [[p1, p1], [p1, p1, p1], [p1, p1], [], [p1], [p1], []] }
      subject(:game_board) { described_class.new(state) }
      it 'draws tokens at the bottom of the columns' do
        board_with_tokens = <<~BOARD
          ┏╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┳╶╶╶╶┓
          ┃    ┃    ┃    ┃    ┃    ┃    ┃    ┃
          ┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫
          ┃    ┃    ┃    ┃    ┃    ┃    ┃    ┃
          ┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫
          ┃    ┃    ┃    ┃    ┃    ┃    ┃    ┃
          ┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫
          ┃    ┃ 🟡 ┃    ┃    ┃    ┃    ┃    ┃
          ┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫
          ┃ 🟡 ┃ 🟡 ┃ 🟡 ┃    ┃    ┃    ┃    ┃
          ┣    ╋    ╋    ╋    ╋    ╋    ╋    ┫
          ┃ 🟡 ┃ 🟡 ┃ 🟡 ┃    ┃ 🟡 ┃ 🟡 ┃    ┃
          ┗━━━━┻━━━━┻━━━━┻━━━━┻━━━━┻━━━━┻━━━━┛
        BOARD
        expect { game_board.draw }.to output(board_with_tokens).to_stdout
      end
    end
  end

  describe '#update' do
    context 'when the board is empty' do
      subject(:game_board) { described_class.new }

      it 'puts in a token in an empty column' do
        value = :player1
        column = 0
        expect { game_board.update(value, column) }.to change { game_board.state[column] }.to([value])
      end
    end

    context 'when there are already tokens in the board' do
      let(:state) { [[:player1, :player2], [], [:player1, :player1, :player2], [:player2], [], [], []] }
      subject(:game_board) { described_class.new(state) }

      it 'adds the token at the top of a column' do
        value = :player1
        column = 2
        game_board.update(value, column)
        expect(game_board.state[column].last).to be value
      end
    end
  end

  describe '#full?' do
    context 'when the board is full' do
      let(:state) do
        [[1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6],
         [1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6]]
      end
      subject(:game_board) { described_class.new(state) }
      it 'returns true' do
        expect(game_board).to be_full
      end
    end

    context 'when the board is not full' do
      let(:state) { [[1, 2, 3, 4, 5, 6], [1, 2, 3], [], [1, 2, 3, 4, 5, 6], [], [1, 2, 3, 4, 5, 6], []] }
      subject(:game_board) { described_class.new(state) }
      it 'returns false' do
        expect(game_board).not_to be_full
      end
    end
  end

  describe '#game_over?'
end
