require 'spec_helper'

describe TicTacToe do
	
	before :all do
		@tictactoe = TicTacToe.new
	end

	describe "#new" do
		it "starts a new game" do
			expect(@tictactoe).to be_an_instance_of TicTacToe
		end
	end
	
	describe "#turn" do
		context "when 'display' is typed in" do
			it "activates the display method" do
				#allow(@tictactoe).to receive(:gets).and_return("display")
				expect(@tictactoe).to receive(:display)
			end
		end
	end

end