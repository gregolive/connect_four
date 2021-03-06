# frozen_string_literal: true

require_relative '../lib/board'

# Run a new game of connect four
class Game
  DISCS = { 1 => 'ð´', 2 => 'ðµ', 3 => 'ð ', 4 => 'ð¡', 5 => 'ð¢', 6 => 'ð£', 7 => 'â«', 8 => 'âª' }.freeze

  def initialize
    @board = GameBoard.new
    @round = 1
    @winner = false
    @player1 = {}
    @player2 = {}
    play_game
  end

  def play_game
    introduction
    ask_info
    @turn = [@player1, @player2].sample
    play_round until @winner
    summary
  end

  def ask_info
    ask_p1
    p1_disc = DISCS.key(@player1[:disc])
    ask_p2(p1_disc)
  end

  def ask_p1
    puts "\e[32mPlayer 1\e[0m please enter your name:"
    @player1[:name] = gets.chomp
    puts "Choose your \e[32mcolor\e[0m using the numbers above:"
    p1_disc = player_move(1, 8)
    @player1[:disc] = DISCS[p1_disc]
  end

  def ask_p2(p1_disc)
    puts "\n\e[33mPlayer 2\e[0m please enter your name:"
    @player2[:name] = gets.chomp
    puts "Choose a different \e[33mcolor\e[0m than #{@player1[:name]} using the numbers above:"
    p2_disc = player_move(1, 8, p1_disc)
    @player2[:disc] = DISCS[p2_disc]
  end

  def play_round
    display_round_info
    make_move
    @winner = @board.winner?(@turn[:disc]) unless @round < 7
    @round += 1
    @turn = @turn == @player1 ? @player2 : @player1 unless @winner
  end

  def display_round_info
    puts "\n\e[34mâââââââ Round #{@round} âââââââ\e[0m\n\n"
    puts "#{@turn[:name]}'s turn.\n\n"
    @board.display_board
    puts 'Enter a column to drop in your disc:'
  end

  def make_move
    loop do
      col = player_move
      col -= 1
      row = @board.find_space(col)
      unless row.nil?
        @board.update_board(@turn[:disc], col, row)
        break
      end
      puts "\e[31mWhoops! Column #{col + 1} is full!\e[0m"
    end
  end

  def player_move(min = 1, max = 7, taken = nil)
    loop do
      column = gets.chomp.to_i
      verified_move = verify_move(column, taken, min, max)
      return verified_move if verified_move

      if column == taken
        puts "\e[31mWhoops! #{taken} is already taken.\e[0m"
      else
        puts "\e[31mWhoops! Please enter a number between #{min} and #{max}.\e[0m"
      end
    end
  end

  def verify_move(move, taken, min = 1, max = 7)
    return move if move.between?(min, max) && move != taken
  end

  def summary
    puts "\n\e[31mâââââââ Game Over ââââââ\e[0m\n\n"
    @board.display_board
    puts "\nCongrats! #{@turn[:name]} wins!\n\n"
  end

  private

  def introduction
    puts <<~HEREDOC

      \e[31mâââââââââââââââââââââââââ CONNECT 4 ââââââââââââââââââââââââââ\e[0m

      Play command line Connect 4 against a friend.
      Be the first player to create a line of four to win!

      '1' ð´  '2' ðµ  '3' ð   '4' ð¡  '5' ð¢  '6' ð£  '7' â«  '8' âª

    HEREDOC
  end
end
