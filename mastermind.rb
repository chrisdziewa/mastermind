require_relative('./game_engine')
require_relative('./player')
require_relative('./code')
require_relative('./view')


player = Player.new

view = View.new(player)
code = Code.new(true)

game = GameEngine.new(code, player, view)
