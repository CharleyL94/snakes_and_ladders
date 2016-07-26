require_relative('./game')
require_relative('./adjuster')

class GameRunner
  def initialize(game)
    @game = game
  end

  def run_game
    puts "Welcome to Snakes and Ladders, first to square #{@game.target() } wins!"
    while( !@game.winner() ) do
      play_turn()
    end


    puts "#{@game.winner[:name] } wins the game! Well done!"
  end

  def play_turn
    puts "#{@game.current_player()[:name]}. Press enter to roll dice."
    gets 
    info = @game.play_turn( rand(1..6) )
    show_turn_info( info )
  end

  def show_turn_info( turn_info )
    puts "#{turn_info[:player_name]} rolled a #{turn_info[:roll]}"
    adjustment = turn_info[:adjustment]
    if( turn_info[:adjustment] )
      if(turn_info[:adjustment] > 0)
        puts "You hit a ladder! Up you go!! #{ adjustment}"
      else puts "Oh no, snake! Move back #{adjustment}"
      end
    end
    puts "#{turn_info[:player_name]} now at position #{turn_info[:end_position]}"
    puts "\n"
  end

end

adjuster = Adjuster.new( {4 => 2, 8 => -1 })
game = Game.new("Jay", "Tony", 10, adjuster)
runner = GameRunner.new(game)
runner.run_game