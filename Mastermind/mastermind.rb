# Gameplay class
class Mastermind

	# The start of gameplay
	def initialize
		puts "You have initiated a new game of Mastermind!\n"

		# Chooses whether codemaker is human or computer
		codemaker_brain = choose_brain("codemaker")
		@codemaker = Player.new(codemaker_brain,:codemaker)

		# Chooses whether codebreaker is human or computer
		codebreaker_brain = choose_brain("codebreaker")
		@codebreaker = Player.new(codebreaker_brain,:codebreaker)

		# Creates a new secret code
		@secret_code = SecretCode.new(codemaker_brain)

	end

	# Chooses whether a player is human or computer
	def choose_brain(player_role)
		puts "\nIs the #{player_role} a 'human' or the 'computer'?"
		brain = gets.chomp.strip.downcase.to_sym
		until brain == :human || brain == :computer
			invalid_input
			puts "\nIs the #{player_role} a 'human' or the 'computer'?"
			brain = gets.chomp.strip.downcase.to_sym
		end
		brain
	end

	# Default message for invalid input
	def invalid_input
		puts "\nInvalid input. Try again.\n"
	end

end

# Nested classes in Mastermind class
class Mastermind

	# Player class
	class Player

		Human = Class.new
		Computer = Class.new

		def initialize(brain, role)
			if brain == :human
				@player = Human.new
			elsif brain == :computer
				@player = Computer.new
			end
		end

		def brain
			@player.class
		end

	end

	# Secret code class
	class SecretCode < Mastermind

		COLORS = [:R,:O,:Y,:G,:B,:P]

		def initialize(brain)
			@secret_code = []
			if brain == :computer
				computer_secret_code
			elsif brain == :human
				human_secret_code_directions
				human_secret_code
			end
			@secret_code
		end

		def computer_secret_code
			4.times do
				@secret_code.push(COLORS[rand(6)])
			end
		end

		def human_secret_code_directions
			puts "\nCodemaker, using the first letter of the"
			puts "following six colors, create a secret code"
			puts "made up of four of these colors (duplicates"
			puts "of a color are allowed): Red ('R'),"
			puts "Orange ('O'), Yellow ('Y'), Green ('G'),"
			puts "Blue ('B'), Purple ('P'). For example, if"
			puts "your code sequence is Red Yellow Red Green,"
			puts "type RYRG with no spaces or punctuation."
		end

		def human_secret_code
			puts "\nYour secret code:"
			secret_string = gets.chomp.strip.upcase
			if secret_string.size != 4 || secret_string.index(/[^ROYGBP]/)
				invalid_input
				human_secret_code
			else
				puts "Your secret code is #{secret_string}"
				@secret_code = secret_string.split(//).map {|color| color.to_sym}
			end
		end
		
	end

end

# Code peg class
class GuessCode

	def initialize(color_sequence_array)
	end

end

# Key peg class
class KeyPeg

	def initialize(guess, secret_code)
		@guess = guess
		@secret_code = secret_code
	end

end

# Start a new game of Mastermind
new_game = Mastermind.new