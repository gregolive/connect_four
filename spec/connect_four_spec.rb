# frozen_string_literal: true

require_relative '../lib/connect_four.rb'
require_relative '../lib/game.rb'

describe Game do
  describe '#player_move' do
    subject(:game_move) { described_class.new }
    
    context 'when the player enters a valid move' do
      before do
        input = '3'
        allow(game_move).to receive(:gets).and_return(input)
      end

      it 'stops looping and does not display an error' do
        min = 1
        max = 7
        error_msg = "\e[31mWhoops! Please enter a number between #{min} and #{max}.\e[0m"
        expect(game_move).not_to receive(:puts).with(error_msg)
        game_move.player_move(min, max)
      end
    end

    context 'when the player enters an invalid move and then a valid move' do
      before do
        invalid = '19'
        valid = '3'
        allow(game_move).to receive(:gets).and_return(invalid, valid)
      end

      it 'displays an error once and then stops looping' do
        min = 1
        max = 7
        error_msg = "\e[31mWhoops! Please enter a number between #{min} and #{max}.\e[0m"
        expect(game_move).to receive(:puts).with(error_msg).once
        game_move.player_move(min, max)
      end
    end
  end

  describe '#verify_move' do
    subject(:game_move_verify) { described_class.new }
    
    context 'when given a valid input and there are no taken numbers' do
      it 'returns the input' do
        input = 6
        taken = nil
        expect(game_move_verify.verify_move(input, taken)).to eq(input)
      end
    end

    context 'when given an invalid input' do
      it 'returns nil' do
        input = 23
        taken = nil
        expect(game_move_verify.verify_move(input, taken)).to be_nil
      end
    end


  end
end

describe GameBoard do
  describe '#update_board' do
    subject(:new_board) { described_class.new}

    context 'when the column is empty' do
      it 'adds the disc to the bottom of the column' do
        disc = '🔵'
        col = 2
        row = new_board.board.length - 1
        new_board.update_board(disc, col, row)
        expect(new_board.board[row][col - 1]).to eq(disc)
      end
    end

    context 'when a column is not empty but has free spaces' do
      it 'adds the disc to the lowest free space' do
        disc = '🔵'
        col = 2
        row = new_board.board.length - 1
        3.times do 
          new_board.update_board(disc, col, row)
          row -= 1
        end
        expect(new_board.board[row + 1][col - 1]).to eq(disc)
      end
    end
  end
end