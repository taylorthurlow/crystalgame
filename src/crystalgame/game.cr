require "./window"
require "./states/game_state"
require "./states/menu_state"
require "./states/play_state"

module CrystalGame
  getter window : CrystalGame::Window

  class Game
    def initialize
      @window = CrystalGame::Window.new(800, 600)
    end

    def run
      while @window.open?
        while event = @window.poll_event
          game_loop_handle_event(event)
        end

        # Game logic
        game_loop_update

        # Render logic
        @window.clear(SF::Color::Black)
        game_loop_draw
        @window.display
      end
    end

    private def game_loop_update
      @window.state.update
    end

    private def game_loop_draw
      @window.state.draw
    end

    private def game_loop_handle_event(event : SF::Event)
      case event
      when SF::Event::Closed
        @window.close
      when SF::Event::KeyPressed
        handle_key_pressed(event.code)
      when SF::Event::KeyReleased
        # handle key release

      end
    end

    private def handle_key_pressed(key : SF::Keyboard::Key)
      puts "Key pressed: #{key.inspect}"
      @window.state.button_down(key)
    end
  end
end
