require "./game_state"

module CrystalGame
  class PlayState < GameState
    def enter; end

    def leave; end

    def update; end

    def draw
      super
    end

    def button_down(key : SF::Keyboard::Key)
      puts "Play state received keydown: #{key.inspect}"
    end

    def button_up(key : SF::Keyboard::Key)
      puts "Play state received keyup: #{key.inspect}"
    end
  end
end
