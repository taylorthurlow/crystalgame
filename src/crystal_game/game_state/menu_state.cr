require "../game_state"
require "./play_state"

module CrystalGame
  class MenuState < GameState
    property? :play_state

    def enter; end

    def leave; end

    def update; end

    def draw
      super

      text = SF::Text.new
      text.font = @window.font
      text.string = "some stupid Crystal game"
      text.character_size = 24
      text.color = SF::Color::White
      text.set_origin(text.local_bounds.width / 2, text.local_bounds.height / 2)
      text.set_position(window.width / 2, window.height / 2)
      @window.draw(text)
    end

    def button_down(key : SF::Keyboard::Key)
      case key
      when SF::Keyboard::Escape, SF::Keyboard::Q
        @window.close
      when SF::Keyboard::N
        @play_state = PlayState.new(@window)
        @window.switch_state(@play_state.not_nil!)
      end
    end

    def button_up(key : SF::Keyboard::Key)
      puts "Menu state received keyup: #{key.inspect}"
    end
  end
end
