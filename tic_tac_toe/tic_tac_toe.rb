class TicTacToe

	def initialize
		@grid_row_first = [[' ', ' ', ' '],[' ', ' ', ' '],[' ', ' ', ' ']]
		@grid_col_first = [[' ', ' ', ' '],[' ', ' ', ' '],[' ', ' ', ' ']]
		@is_tie = false
	end

	def start	
		@p1 = create_player 1
		@p2 = create_player 2

		is_p1_turn = false

		until game_over?
			is_p1_turn = !is_p1_turn
			draw_board
			player = is_p1_turn ? @p1 : @p2
			take_turn player
		end
		puts
		draw_board
		if @is_tie
			puts "It's a tie!"
		else
			puts "#{player.name} wins!"
		end
	end

	private
	def create_player(num)
		puts "Player #{num}: What is your name?"
		name = gets.chomp
		puts 'And your sign? (please only one character)'
		sign = gets.chomp
		Player.new name, sign
	end

	def draw_board
		i = 1
		line = "   -------------"
		puts "     1   2   3"
		@grid_row_first.each do |row|
			puts line
			print i.to_s + '  '
			i += 1
			row.each do |cell|
				print "| #{cell} "
			end
			puts "|"
		end
		puts line
		puts ''
	end

	def take_turn(player)
		puts "#{player.name}'s turn now!"
		puts "Where would you like to mark your sign?"
		row, col = ''
		until /[1-3]/ === row 
			puts "row #? (must be 1, 2, or 3)"
			row = gets.chomp
		end
		until /[1-3]/ === col 
			puts "column #? (must be 1, 2, or 3)"
			col = gets.chomp
		end

		@grid_row_first[row.to_i - 1][col.to_i - 1] = player.sign
		@grid_col_first[col.to_i - 1][row.to_i - 1] = player.sign
		puts 'Turn completed!'
		puts
	end

	def game_over?
		@grid_row_first.each do |row|
			if row.all? { |cell| cell == @p1.sign }
				return true
			elsif row.all? { |cell| cell == @p2.sign }
				return true
			end
		end

		@grid_col_first.each do |col|
			if col.all? { |cell| cell == @p1.sign }
				return true
			elsif col.all? { |cell| cell == @p2.sign }
				return true
			end
		end

		center_sign = @grid_row_first[1][1]
		return false if center_sign == ' '

		if @grid_row_first[0][0] == center_sign && @grid_row_first[2][2] == center_sign
			return true
		elsif @grid_row_first[0][2] == center_sign && @grid_row_first[2][0] == center_sign
			return true
		end

		@is_tie = true
		@grid_row_first.each do |row|
			row.each do |cell|
				@is_tie = false if cell == ' '
			end
		end
		return true if @is_tie

		false
	end

	class Player
		attr_accessor :name, :sign

		def initialize(name, sign) 
			@name = name
			@sign = sign
		end
	end

end

answer = 'y'
while answer == 'y'
	t = TicTacToe.new
	t.start
	puts "Play a new game? [y, n]"
	answer = gets.chomp
end