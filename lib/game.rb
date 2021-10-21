# frozen_string_literal: true

# Run a new game of connect four
class Game
  def initialize
    @board = create_board
    play_game
  end

  def play_game
    introduction
    display_board(@board)
  end

  def create_board(rows = 6, cols = 7, disc = '⭕', board = [])
    row = Array.new(cols, disc)
    rows.times { board.push(row) }
    board
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

  def display_board(array)
    puts '┏━━━━━━━━━━━━━━━━━━━━━━┓'
    array.each do |row| 
      print '┃'
      row.each_with_index { |disc, index| print index == 6 ? " #{disc} ┃\n" : " #{disc}" }
    end
    puts "┣━━━━━━━━━━━━━━━━━━━━━━┫\n┃  1  2  3  4  5  6  7 ┃\n┗━━━━━━━━━━━━━━━━━━━━━━┛"
  end

end