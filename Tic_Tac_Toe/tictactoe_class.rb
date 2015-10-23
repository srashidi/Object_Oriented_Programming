# The general class for the game
class TicTacToe

	attr_accessor :game_board, :row1, :row2, :row3

	def initialize
		@game_board = GameBoard.new
		puts "You have initiated a game of Tic-Tac-Toe!"
		puts "When choosing a spot on the board, use the"
		puts "numbers 1 through 9 like so:"
		puts "\n"
		puts " 1 | 2 | 3 \n-----------"
		puts " 4 | 5 | 6 \n-----------"
		puts " 7 | 8 | 9 \n"
		puts "X goes first."
		round("X")
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
		else
			puts "Not a valid entry. Try again."
			round(piece)
		end
		if spot =~ /\s/
			case position
			when 1
				@gameboard.row1[1] = piece
			when 2
				@gameboard.row1[5] = piece
			when 3
				@gameboard.row1[9] = piece
			when 4
				@gameboard.row2[1] = piece
			when 5
				@gameboard.row2[5] = piece
			when 6
				@gameboard.row2[9] = piece
			when 7
				@gameboard.row3[1] = piece
			when 8
				@gameboard.row3[5] = piece
			when 9
				@gameboard.row3[9] = piece
			end
			puts "Your #{piece} piece was placed in position #{position}."
			if win?
				puts "#{piece} wins!"
				# break
			end
			if piece == "X"
				piece = "O"
			elsif piece == "O"
				piece = "X"
			end
			round(piece)		
		else
			puts "There is already a piece in position #{position}. Try again."
			round(piece)
		end
	end

	def round(piece)
		puts "Choose position for #{piece}:"
		position = gets.chomp.to_i
		place_piece(position,piece)
	end

	class GameBoard

		attr_accessor :row1, :row2, :row3

		def initialize
			@row1 = "   |   |   "
			@row2 = "   |   |   "
			@row3 = "   |   |   "
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

	end

end

# Create a new game
new_game = TicTacToe.new
