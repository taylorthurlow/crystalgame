module CrystalGame
  class Game
    property :window

    def initialize
      @window = SF::RenderWindow.new(SF::VideoMode.new(800, 600), "Crystal Game")
      @window.vertical_sync_enabled = true
    end

    def run
      while @window.open?
        while event = @window.poll_event
          game_loop_handle_event(event)
        end
      end
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
    end
  end
end
