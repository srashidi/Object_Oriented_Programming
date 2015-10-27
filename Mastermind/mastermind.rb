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

	# Computer creates random code
	def computer_random_code
		code_array = []
		4.times do
			code_array.push(COLORS[rand(6)])
		end
		code_array
	end

	def round_feedback(guesser,guess,tries)
		puts "Guess ##{tries}: #{guesser.capitalize} guessed #{guess.join}"
		KeyPeg.new(guess,@secret_code) unless guess == @secret_code
	end

	def human_rounds
		tries = 0
		guess = []
		human_guess_directions
		until guess == @secret_code || tries == 12
			puts "\nYour guess:"
			guess = human_code_input
			tries += 1
			round_feedback("you",guess,tries)
		end
		puts guess == @secret_code ? "This is CORRECT! It took #{tries} tries." \
		: "\nFailure! You didn't guess in the first 12 tries."
	end

	def computer_rounds
		tries = 0
		guess = []
		until guess == @secret_code
			guess = computer_random_code
			tries += 1
			round_feedback("computer",guess,tries)
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

	def initialize(guess, secret)
		@guess = guess
		@secret = secret
		a = correct_color_correct_position
		b = correct_color_wrong_position
		feedback(a,b)
	end

	def correct_color_correct_position
		i = 0
		num = 0
		4.times do
			if @guess[i] == @secret[i]
				num += 1
				@guess[i] = @guess[i].to_s
				@secret[i] = @secret[i].to_s
			end
			i += 1
		end
		num
	end

	def correct_color_wrong_position
		i = 0
		j = 0
		num = 0
		@guess.each do |guess_color|
			if guess_color.is_a?(Symbol)
				@secret.each do |secret_color|
					if guess_color == secret_color
						num += 1
						@guess[i] = @guess[i].to_s
						@secret[j] = @secret[j].to_s
					end
					j += 1
				end
			end
			i += 1
			j = 0
		end
		@guess.map! {|color| color.to_sym}
		@secret.map! {|color| color.to_sym}
		num
	end

	def feedback(color_and_position_correct,just_color_correct)
		if color_and_position_correct == 1 && just_color_correct == 1
			puts "You have #{color_and_position_correct} color that is correct and\n\
			in the correct position and #{just_color_correct} color that is\n\
			correct but in the wrong position."
		elsif color_and_position_correct == 1
			puts "You have #{color_and_position_correct} color that is correct and\n\
			in the correct position and #{just_color_correct} colors that are\n\
			correct but in the wrong position."
		elsif just_color_correct == 1
			puts "You have #{color_and_position_correct} colors that are correct and\n\
			in the correct position and #{just_color_correct} color that is\n\
			correct but in the wrong position."
		else
			puts "You have #{color_and_position_correct} colors that are correct and\n\
			in the correct position and #{just_color_correct} colors that are\n\
			correct but in the wrong position."
		end	
	end

end

# Start a new game of Mastermind
new_game = Mastermind.new