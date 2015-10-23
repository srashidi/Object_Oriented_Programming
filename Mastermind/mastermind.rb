# Gameplay class
class Mastermind

	# The start of gameplay
	def initialize
		puts "You have initiated a new game of Mastermind!"

		# Chooses whether codemaker is human or computer
		codemaker_brain = choose_brain("codemaker")
		@codemaker = Player.new(codemaker_brain,:codemaker)

		# Chooses whether codebreaker is human or computer
		codebreaker_brain = choose_brain("codebreaker")
		@codebreaker = Player.new(codebreaker_brain,:codebreaker)
	end

	# Chooses whether a player is human or computer
	def choose_brain(player_role)
		puts "\nIs the #{player_role} a 'human' or the 'computer'?"
		brain = gets.chomp.strip.downcase
		until brain == "human" || brain == "computer"
			invalid_input
			puts "\nIs the #{player_role} a 'human' or the 'computer'?"
			brain = gets.chomp.strip.downcase
		end
		brain
	end

	# Default message for invalid input
	def invalid_input
		puts "\nInvalid input. Try again.\n"
	end

end

# Player class
class Player

	def initialize(brain, role)
	end

end

# Secret code class
class SecretCode

	def initialize(color1, color2, color3, color4)
	end
	
end

# Code peg class
class CodePeg

	def initialize(color)
	end

end

# Key peg class
class KeyPeg

	def initialize(color)
	end

end

# Start a new game of Mastermind
new_game = Mastermind.new