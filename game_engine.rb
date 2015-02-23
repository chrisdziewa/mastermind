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
		until @guesses > 10 || code_broken?
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
		puts "    [red, orange, yellow, green, blue, white]"
		puts
		collect_guess
		while !verify_guess
			puts "Error: You must choose 4 valid colors from the list."
			collect_guess
		end
	end

	def collect_guess 
		puts "Separate each color by a space:"
		@current_guess = gets.chomp.downcase.split(" ")
	end

	def verify_guess 
		@current_guess.each do |color|
			if !@code.color_choices.include?(color) || @current_guess.length != 4
				return false
			end
		end
	end

	def code_broken?
		@current_guess == @code.code
	end

	def end_game 
		puts "The code was #{@code.code.inspect}"
		puts "Game over!"
	end
end