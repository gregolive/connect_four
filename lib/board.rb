# frozen_string_literal: true

class GameBoard
  attr_reader :board

  EMPTY_BOARD = [ ['⭕','⭕','⭕','⭕','⭕','⭕','⭕'],
                  ['⭕','⭕','⭕','⭕','⭕','⭕','⭕'],
                  ['⭕','⭕','⭕','⭕','⭕','⭕','⭕'],
                  ['⭕','⭕','⭕','⭕','⭕','⭕','⭕'],
                  ['⭕','⭕','⭕','⭕','⭕','⭕','⭕'],
                  ['⭕','⭕','⭕','⭕','⭕','⭕','⭕'] ]
  
  def initialize
    @board = EMPTY_BOARD
  end

  def display_board
    puts '┏━━━━━━━━━━━━━━━━━━━━━━┓'
    @board.each do |row| 
      print '┃'
      row.each_with_index { |disc, index| print index == 6 ? " #{disc} ┃\n" : " #{disc}" }
    end
    puts "┣━━━━━━━━━━━━━━━━━━━━━━┫\n┃  1  2  3  4  5  6  7 ┃\n┗━━━━━━━━━━━━━━━━━━━━━━┛"
  end

  def find_space(col)
    rows = Array.new
    @board.each_with_index { |row, index| rows.push(index) if row[col] == '⭕' }
    rows.last
  end

  def update_board(disc, col, row)
    @board[row][col] = disc
  end
end