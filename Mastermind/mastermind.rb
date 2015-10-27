# Gameplay class
class Mastermind

	# The array of possible color pegs
	COLORS = [:R,:O,:Y,:G,:B,:P]

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
		if codemaker_brain == :computer
			@secret_code = computer_random_code
		elsif codemaker_brain == :human
			@secret_code = human_secret_code
		end

		if codemaker_brain == :human && codebreaker_brain == :human
			puts "\v\v\v\v\v\v\v\v\v\v\v\v\v\v\v\
			\v\v\v\v\v\v\v\v\v\v\v\v\v\v\v\v\v\v\v\v\v"
		end

		# Starts the codebreaker's player rounds
		if codebreaker_brain == :human
			human_rounds
		elsif codebreaker_brain == :computer
			computer_rounds
		end
				
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

	# Takes inputted code from a human player
	def human_code_input
		code_string = gets.chomp.strip.upcase
		if code_string.size != 4 || code_string.index(/[^ROYGBP]/)
			invalid_input
			human_code_input
		else
			code = code_string.split(//).map {|color| color.to_sym}
		end
	end

	def human_rounds
		tries = 0
		guess = []
		until guess == @secret_code
			human_guess_directions
			puts "\nYour guess:"
			guess = human_code_input
			tries += 1
			puts "Guess ##{tries}: You guessed #{guess.join}"
			puts "This is INCORRECT!" unless guess == @secret_code
		end
		puts "This is CORRECT! It took #{tries} tries."
	end

	# Gives directions for the human codebreaker to guess the secret code
	def human_guess_directions
		puts "\nCodebreaker, using the first letter of the\n\
		following six colors, guess the secret code\n\
		made up of four of these colors (duplicates\n\
		of a color are allowed): Red ('R'),\n\
		Orange ('O'), Yellow ('Y'), Green ('G'),\n\
		Blue ('B'), Purple ('P'). For example, if\n\
		your code sequence is Red Yellow Red Green,\n\
		type RYRG with no spaces or punctuation."
	end

	# Computer creates random code
	def computer_random_code
		code_array = []
		4.times do
			code_array.push(COLORS[rand(6)])
		end
		code_array
	end

	def computer_rounds
		tries = 0
		guess = []
		until guess == @secret_code
			guess = computer_random_code
			tries += 1
			puts "Guess ##{tries}: Computer guessed #{guess.join}"
			puts "This is INCORRECT!" unless guess == @secret_code
		end
		puts "This is CORRECT! It took #{tries} tries."
	end

	# Takes input for the secret code
	def human_secret_code
		human_secret_code_directions
		puts "\nYour secret code:"
		secret_code = human_code_input
		puts "Your secret code is #{secret_code.join}"
		secret_code
	end

	# Gives directions for the human player to create a secret code
	def human_secret_code_directions
		puts "\nCodemaker, using the first letter of the\n\
		following six colors, create a secret code\n\
		made up of four of these colors (duplicates\n\
		of a color are allowed): Red ('R'),\n\
		Orange ('O'), Yellow ('Y'), Green ('G'),\n\
		Blue ('B'), Purple ('P'). For example, if\n\
		your code sequence is Red Yellow Red Green,\n\
		type RYRG with no spaces or punctuation."
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

		# Define player type classes
		Human = Class.new
		Computer = Class.new

		# Creates new player based on player type
		def initialize(brain, role)
			if brain == :human
				@player = Human.new
			elsif brain == :computer
				@player = Computer.new
			end
		end

		# Returns player type as a class
		def brain
			@player.class
		end

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