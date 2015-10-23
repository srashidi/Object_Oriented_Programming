# The general class for the game
class TicTacToe

	WIN = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

	attr_accessor :row1, :row2, :row3

	def initialize
		@row1 = "   |   |   "
		@row2 = "   |   |   "
		@row3 = "   |   |   "
		puts "You have initiated a game of Tic-Tac-Toe!"
		puts "When choosing a spot on the board, use the"
		puts "numbers 1 through 9 like so:"
		puts "\n"
		puts " 1 | 2 | 3 \n-----------"
		puts " 4 | 5 | 6 \n-----------"
		puts " 7 | 8 | 9 \n\n"
		puts "X goes first."
		round("X")
	end

	def display
		puts "\n"
		puts row1
		puts "-----------"
		puts row2
		puts "-----------"
		puts row3
		puts "\n"
	end

	def place_piece(position,piece)
		case position
		when 1
			spot = row1[1]
		when 2
			spot = row1[5]
		when 3
			spot = row1[9]
		when 4
			spot = row2[1]
		when 5
			spot = row2[5]
		when 6
			spot = row2[9]
		when 7
			spot = row3[1]
		when 8
			spot = row3[5]
		when 9
			spot = row3[9]
		when "help"
			puts "\n"
			puts " 1 | 2 | 3 \n-----------"
			puts " 4 | 5 | 6 \n-----------"
			puts " 7 | 8 | 9 \n\n"
			round(piece)
		else
			puts "\nNot a valid entry. Try again."
			round(piece)
		end
		if spot =~ /\s/
			case position
			when 1
				row1[1] = piece
			when 2
				row1[5] = piece
			when 3
				row1[9] = piece
			when 4
				row2[1] = piece
			when 5
				row2[5] = piece
			when 6
				row2[9] = piece
			when 7
				row3[1] = piece
			when 8
				row3[5] = piece
			when 9
				row3[9] = piece
			end
			puts "\nYour #{piece} piece was placed in position #{position}."
			display
			if piece == "X"
				piece = "O"
			elsif piece == "O"
				piece = "X"
			end
			round(piece)		
		else
			puts "\nThere is already a piece in position #{position}. Try again."
			round(piece)
		end
	end

	def round(piece)
		puts "\nChoose position for #{piece}, or ask for 'help':"
		position = gets.chomp.strip.downcase
		position = position.to_i unless position == "help"
		place_piece(position,piece)
	end

end

# Create a new game
new_game = TicTacToe.new