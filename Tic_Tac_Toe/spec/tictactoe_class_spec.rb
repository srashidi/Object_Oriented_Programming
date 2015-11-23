require 'spec_helper'

describe TicTacToe do

	before :each do
		@tictactoe = TicTacToe.new(:test_mode)
	end

	describe "#new" do
		it "starts a new game" do
			expect(@tictactoe).to be_an_instance_of TicTacToe
		end
	end

	describe "#spot_empty?" do

		before do
			@tictactoe.place_piece(5,"X")
			@tictactoe.place_piece(3,"O")
			@tictactoe.place_piece(1,"X")
			@tictactoe.place_piece(9,"O")
			@tictactoe.place_piece(6,"X")
		end

		context "for an empty spot on the gameboard" do
			it "is true" do
				expect( @tictactoe.spot_empty?(4) ).to be_truthy
			end
		end

		context "for a spot on the gameboard with X" do
			it "is false" do
				expect( @tictactoe.spot_empty?(1) ).to be_falsey
			end
		end

		context "for a spot on the gameboard with O" do
			it "is false" do
				expect( @tictactoe.spot_empty?(9) ).to be_falsey
			end
		end

	end

	describe "#display" do

		context "when no moves have been made" do

			it "has no pieces" do
				expect(@tictactoe.row1).to eql "   |   |   "
				expect(@tictactoe.row2).to eql "   |   |   "
				expect(@tictactoe.row3).to eql "   |   |   "
			end

		end

		context "when one move has been made" do

			before do
				@tictactoe.place_piece(5,"X")
			end

			it "has the piece in the correct position" do
				expect(@tictactoe.row1).to eql "   |   |   "
				expect(@tictactoe.row2).to eql "   | X |   "
				expect(@tictactoe.row3).to eql "   |   |   "
			end

		end

		context "when moves have been made" do

			before do
				@tictactoe.place_piece(5,"X")
				@tictactoe.place_piece(3,"O")
				@tictactoe.place_piece(1,"X")
				@tictactoe.place_piece(9,"O")
				@tictactoe.place_piece(6,"X")
			end

			it "has pieces in the correct positions" do
				expect(@tictactoe.row1).to eql " X |   | O "
				expect(@tictactoe.row2).to eql "   | X | X "
				expect(@tictactoe.row3).to eql "   |   | O "
			end

		end

	end

	describe "#win?" do

		context "when player does not make winning move" do

			before :each do
				@tictactoe.place_piece(5,"X")
				@tictactoe.place_piece(3,"O")
				@tictactoe.place_piece(1,"X")
				@tictactoe.place_piece(9,"O")
				@tictactoe.place_piece(6,"X")
			end

			it "is false for X" do
				expect( @tictactoe.win?("X") ).to be_falsey
			end

			it "is false for O" do
				expect( @tictactoe.win?("O") ).to be_falsey
			end

		end

		context "when player makes winning move" do

			before :each do
				@tictactoe.place_piece(5,"X")
				@tictactoe.place_piece(3,"O")
				@tictactoe.place_piece(1,"X")
				@tictactoe.place_piece(6,"O")
				@tictactoe.place_piece(9,"X")
			end

			it "is true for player that wins" do
				expect( @tictactoe.win?("X") ).to be_truthy
			end

			it "is false for player that loses" do
				expect( @tictactoe.win?("O") ).to be_falsey
			end

		end

	end

	describe "#all_spots_full?" do

		context "when players fill all spots with no winning move" do

			before do
				@tictactoe.place_piece(5,"X")
				@tictactoe.place_piece(3,"O")
				@tictactoe.place_piece(1,"X")
				@tictactoe.place_piece(9,"O")
				@tictactoe.place_piece(6,"X")
				@tictactoe.place_piece(4,"O")
				@tictactoe.place_piece(8,"X")
				@tictactoe.place_piece(2,"O")
				@tictactoe.place_piece(7,"X")
			end

			it "is true" do
				expect(@tictactoe.all_spots_full?).to be_truthy
				expect( @tictactoe.win?("X") ).to be_falsey
				expect( @tictactoe.win?("O") ).to be_falsey
			end

		end

		context "when players have filled no spots" do

			it "is false" do
				expect(@tictactoe.all_spots_full?).to be_falsey
			end

		end

		context "when players have filled some spots with no winning move" do

			before do
				@tictactoe.place_piece(5,"X")
				@tictactoe.place_piece(3,"O")
				@tictactoe.place_piece(1,"X")
				@tictactoe.place_piece(9,"O")
				@tictactoe.place_piece(6,"X")
			end

			it "is false" do
				expect(@tictactoe.all_spots_full?).to be_falsey
				expect( @tictactoe.win?("X") ).to be_falsey
				expect( @tictactoe.win?("O") ).to be_falsey
			end

		end

	end

end