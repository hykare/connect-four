require_relative 'player'
require_relative 'game_board'

class ConnectFour
  attr_accessor :current_player
  attr_reader :board, :players

  def initialize(board = GameBoard.new)
    @board = board
    @players = [Player.new("yellow", "🟡"), Player.new("purple", "🟣")]
    @current_player = players.first
  end

  def play
    play_round until board.win?(current_player.token)
    win_message
  end

  private

  def play_round
    switch_player
    refresh_board
    column_number = get_player_input
    board.update(current_player.token, column_number)
    refresh_board
  end

  def switch_player
    self.current_player = players.rotate!.first
  end

  def refresh_board
    system 'clear'
    board.draw
  end

  def get_player_input
    puts " #{current_player.name}, input column number 1-7"
    gets.chomp.to_i - 1
  end

  def win_message
    print "\n           #{current_player.name} has won!\n\n"
  end
end
