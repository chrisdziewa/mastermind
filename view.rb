class View 
	def initialize(player)
		@player = player
	end

	def intro
		puts "Welcome to Mastermind!"
		puts "This game involves a code breaker and a code setter."
		puts "The code setter chooses 4 colors in a specific order, and the"
		puts "code breaker has 10 attempts to guess the correct code. If the"
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