class Code 
	attr_accessor :code
	attr_reader :color_choices
	def initialize(is_computer)
		@code = []
		@is_computer = is_computer
		@color_choices = [
							"red", "orange", "yellow", 
							"green", "blue", "white"
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
		rand(0..5)
	end
end