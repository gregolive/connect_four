# frozen_string_literal: true

class GameBoard
  def initialize
    @board = create_board
  end

  def create_board(rows = 6, cols = 7, disc = '⭕', board = [])
    row = Array.new(cols, disc)
    rows.times { board.push(row) }
    board
  end

  def display_board
    puts '┏━━━━━━━━━━━━━━━━━━━━━━┓'
    @board.each do |row| 
      print '┃'
      row.each_with_index { |disc, index| print index == 6 ? " #{disc} ┃\n" : " #{disc}" }
    end
    puts "┣━━━━━━━━━━━━━━━━━━━━━━┫\n┃  1  2  3  4  5  6  7 ┃\n┗━━━━━━━━━━━━━━━━━━━━━━┛"
  end

  def update_board(disc, col)
    col -= 1
    p row = find_space(col)
    @board[row][col] = disc
  end
  
  def find_space(col)
    rows = Array.new
    @board.each_with_index { |row, index| rows.push(index) if row[col] == '⭕' }
    rows.last
  end
end