# The general class for the game
class TicTacToe

	# Possibilities of winning
	WIN = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

	# Introduces the game and begins the first round
	def initialize(input_given = nil)
		@row1 = "   |   |   "
		@row2 = "   |   |   "
		@row3 = "   |   |   "
		@array_X = []
		@array_O = []
		@input_given = input_given
		introduction unless input_given
	end

	def introduction
		puts "You have initiated a game of Tic-Tac-Toe!"
		puts "When choosing a spot on the board, use the"
		puts "numbers 1 through 9 like so:"
		puts "\n"
		puts " 1 | 2 | 3 \n-----------"
		puts " 4 | 5 | 6 \n-----------"
		puts " 7 | 8 | 9 \n\n"
		puts "X goes first."
		turn("X")
	end

	# Initiates a player's turn
	def turn(piece)
		puts "\nChoose position for #{piece}, or ask to 'display'"
		puts "the board, or ask for 'help', or ask to 'exit':"
		position = STDIN.gets.chomp.strip.downcase
		if position == "help"
			help
			turn(piece)
		elsif position == "display"
			display
			turn(piece)
		elsif position == "exit"
			puts "Goodbye!"
		elsif /\d/ =~ position
			transition(position,piece)
			display
			if piece == "X"
				piece = "O" unless win?(piece)
			elsif piece == "O"
				piece = "X" unless win?(piece)
			end
			if win?(piece)
				puts "#{piece}'s win!"
				play_again_input
			elsif all_spots_full?
				puts "It's a draw!"
				play_again_input
			else
				turn(piece)
			end
		else
			puts "\nNot a valid entry. Try again."
			turn(piece)
		end
	end

	def transition(position,piece)
		position = position.to_i
		if spot_empty?(position)
			place_piece(position,piece)
			puts "\nYour #{piece} piece was placed in position #{position}."
		end
	end

	# Checks if the spot chosen on the gameboard is empty
	def spot_empty?(position)
			case position
			when 1
				spot = @row1[1]
			when 2
				spot = @row1[5]
			when 3
				spot = @row1[9]
			when 4
				spot = @row2[1]
			when 5
				spot = @row2[5]
			when 6
				spot = @row2[9]
			when 7
				spot = @row3[1]
			when 8
				spot = @row3[5]
			when 9
				spot = @row3[9]
			end
			if spot =~ /\s/
				true
			else
				false
			end
		end

	# Places a piece in the chosen position
	def place_piece(position,piece)
		case position
		when 1
			@row1[1] = piece
		when 2
			@row1[5] = piece
		when 3
			@row1[9] = piece
		when 4
			@row2[1] = piece
		when 5
			@row2[5] = piece
		when 6
			@row2[9] = piece
		when 7
			@row3[1] = piece
		when 8
			@row3[5] = piece
		when 9
			@row3[9] = piece
		end
		if piece == "X"
			@array_X.push(position)
		elsif piece == "O"
			@array_O.push(position)
		end
	end

	# Displays the game board
	def display
		puts "\n"
		puts @row1
		puts "-----------"
		puts @row2
		puts "-----------"
		puts @row3
		puts "\n"
	end

	# When player calls for help, displays guide gameboard
	def help
		puts "\n"
		puts " 1 | 2 | 3 \n-----------"
		puts " 4 | 5 | 6 \n-----------"
		puts " 7 | 8 | 9 \n\n"
	end

	# Checks if the current player has won
	def win?(piece)
		if piece == "X"
			current_array = @array_X
		elsif piece == "O"
			current_array = @array_O
		end
		WIN.each do |possibility|
			if possibility - current_array == []
				return true
			end
		end
		false
	end

	# Gives the option of playing again
	def play_again_input
		puts "Play again? (type 'yes' or 'no')"
		response = STDIN.gets.chomp.strip.downcase
		unless response == "yes" || response == "no"
			puts "\nNot a valid entry. Try again."
			play_again_input
		end
		play_again(response)
	end

	def play_again(response)
		if response == "yes"
			puts "\n\n"
			initialize(@input_given)
		elsif response == "no"
			puts "Goodbye!"
		end
	end

	# Checks if all the spots on the gameboard have been filled
	def all_spots_full?
		true if @array_X.size == 5
	end

end