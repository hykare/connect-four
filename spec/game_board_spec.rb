require_relative '../lib/game_board'

describe GameBoard do
  describe '#draw'

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

  describe '#game_over?'
end
