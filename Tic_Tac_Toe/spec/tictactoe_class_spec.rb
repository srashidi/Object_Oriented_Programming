require 'spec_helper'

describe TicTacToe do
	
	describe "#new" do
		it "starts a new game" do
			expect(subject).to be_an_instance_of TicTacToe
			subject.user_input
		end
		
	end
=begin
	describe "#win?" do
		
		before :each do
			@tictactoe = TicTacToe.new
		end
		
		context "player does not make winning move" do
			it "moves on to the next player" do
				@tictactoe.user_input("5\n")
				expect(@tictactoe).to receive(:turn)
			end
		end
		
		context "player makes winning move" do
			it "ends the game and asks the player to play again" do
			end
		end
		
		after :example do
			STDIN.puts "exit\n"
		end
		
	end
=end
end