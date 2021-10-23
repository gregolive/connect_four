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

  def winner?(disc, streak = 0)
    to_check = @board + @board.transpose + collect_diagonals
    to_check.each do |arr|
      arr.each do |ele|
        streak = ele == disc ? streak + 1 : 0
        return true if streak >= 4
      end
    end
    false
  end

  def collect_diagonals
    diagonals = diagonals_from_left + diagonals_from_right
    delete_small_sections(diagonals)
  end
  
  def diagonals_from_right(padded_matrix = [])
    padding = @board.size - 1
  
    @board.each do |row|
        inverse_padding = @board.size - padding
        padded_matrix << ([nil] * inverse_padding) + row + ([nil] * padding)
        padding -= 1    
    end
    padded_matrix.transpose.map(&:compact)
  end
  
  def diagonals_from_left(padded_matrix = [])
    padding = 0
  
    @board.each do |row|
      inverse_padding = @board.size - padding
      padded_matrix << ([nil] * inverse_padding) + row + ([nil] * padding)
      padding += 1    
    end
    padded_matrix.transpose.map(&:compact)
  end

  def delete_small_sections(array)
    array.delete_if {|sub| sub.length < 4 }
  end
end