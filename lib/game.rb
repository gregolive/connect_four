# frozen_string_literal: true

require_relative '../lib/board.rb'

# Run a new game of connect four
class Game
  def initialize
    @board = GameBoard.new
    play_game
  end

  def play_game
    #introduction
    #ask_names
    @board.display_board
    @board.update_board('🔵', 2)
    @board.display_board
  end

  def ask_names
    puts "\e[34mPlayer 1\e[0m please enter your name:"
    @player1 = gets.chomp
    puts "\n\e[33mPlayer 2\e[0m please enter your name:"
    @player2 = gets.chomp
  end

  def player_move(min = 1, max = 7)
    loop do
      column = gets.chomp
      verified_move = verify_move(column.to_i)
      return verified_move if verified_move

      puts "\e[31mWhoops! Please enter a number between #{min} and #{max}.\e[0m"
    end
  end

  def verify_move(move, min = 1, max = 7)
    return move if move.between?(min, max)
  end

  private

  def introduction
    puts <<~HEREDOC

      \e[31mCONNECT 4\e[0m

      Play command line Connect 4 against a friend.
      Be the first player to create a line of four to win!

      '1' 🔴  '2' 🔵  '3' 🟠  '4' 🟡  '5' 🟢  '6' 🟣  '7' ⚫  '8' ⚪

    HEREDOC
  end

end