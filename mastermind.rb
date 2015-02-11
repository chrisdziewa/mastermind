class Player 
	attr_accessor :name
	def initialize; end
end

class ComputerPlayer < Player
	attr_reader
	def initialize()
		@name = "Master Computer"
	end
end

class Code 
	attr_accessor :code
	def initialize(is_computer)
		@code = []
		@is_computer = is_computer
		@color_choices = [
							"red", "orange", "yellow", 
							"green", "blue", "white", 
							"black", "brown"
						 ]
	end

	def set_code
		if @is_computer
	 		@code = computer_choice
	 	else
	 		@code = player_choice
	 	end
	end

	private

	def player_choice
		@code = %w(red yellow blue green)
	end

	def computer_choice
		new_code = []
		while new_code.length < 4 
			index = random_index
			color = @color_choices[index]
			if !new_code.include?(color) 			
				new_code.push(color)
			end
		end
		new_code
	end

	def random_index
		rand(0..7)
	end
end

class View 
	def initialize(player)
		@player = player
	end

	def intro
		puts "Welcome to Mastermind!"
		puts "This game involves a code breaker and a code setter."
		puts "The code setter chooses 4 colors in a specific order, and the"
		puts "code breaker has 12 attempts to guess the correct code. If the"
		puts "code breaker is unable to solve the code, the code setter wins." 
		puts "Likewise, if the code breaker solves the code, that person wins."	

		puts "Feedback:"
		puts "Each X means you have one color that is correct and" 
		puts "in the right place. Each O means that a color you" 
		puts "have guessed is present in the code but in the wrong place."
	end

	def show_board(list)
		puts "========================================================================="
		puts "Here is what the board looks like now:"
		puts 
		list.each do |guess|
			puts guess
		end
		puts "========================================================================="
		puts
	end

	def congratulate
		puts "================================================================="
		puts "You WIN!!!!!!!"
		puts "================================================================="
	end
end

class GameEngine 
	def initialize(code, player, view)
		@code = code
		@code.set_code
		@player = player
		@view = view
		@guesses = 1
		@current_guess = []
		@all_guesses = []
		@view.intro
		@feedback = ["__", "__", "__", "__"]
		play
	end

	def play
		until @guesses > 12 || code_broken?
			ask_for_guess 
			@guesses += 1

			create_feed_back_string
			update_guesses
			
			if code_broken?
				@view.congratulate
			else 
				@view.show_board(@all_guesses)
			end
		end
		end_game
	end

	def create_feed_back_string 
		@feedback = []
		amounts = feedback_loop
		empty_amount = 4 - amounts[1] - amounts[0]
		#x's found
		amounts[0].times do 
			insert_feedback_value("X")
		end

		amounts[1].times do 
			insert_feedback_value("O")
		end

		empty_amount.times do 
			insert_feedback_value("__")
		end
	end

	def insert_feedback_value(symbol)
		@feedback.push(symbol)
	end


	def update_guesses
		@all_guesses.unshift(" Turn #{@guesses - 1}: #{@current_guess} ======> #{@feedback.inspect}")
	end

	def feedback_loop 
		right_place = 0
		wrong_position = 0 
		@code.code.each_with_index do |color, index| 
			if color_present?(color)
				if color_in_correct_spot?(color, index)
					right_place += 1
				else
					wrong_position += 1
				end
			end
		end
		# Fill in empty spaces where colors weren't present
		nothing_found = 4 - (right_place + wrong_position)
		[right_place, wrong_position]
	end

	def color_present?(color)
		@current_guess.include?(color)
	end

	def color_in_correct_spot?(color, index)
		@current_guess[index] == color
	end

	def ask_for_guess
		puts ""
		puts "Please choose four different colors from the following list:" 
		puts
		puts "    [red, orange, yellow, green, blue, black, white, brown]"
		puts
		puts "Separate each color by a space:"
		@current_guess = gets.chomp.downcase.split(" ")
	end

	def code_broken?
		@current_guess == @code.code
	end

	def end_game 
		puts "Game over!"
	end
end

player = Player.new

view = View.new(player)
code = Code.new(true)

game = GameEngine.new(code, player, view)
