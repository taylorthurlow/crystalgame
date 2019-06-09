module CrystalGame
  abstract class GameState
    getter window : CrystalGame::Window
    property paused : Bool

    def initialize(window)
      @window = window
      @paused = false
      @fade = 0
      @fading_out = false
      @fading_in = false
    end

    def self.switch(new_state : GameState)
      @window.state.leave
      @window.state = new_state
      new_state.enter
    end

    def draw(fade_speed : Int8 = 5)
      if @fade > 0
        width = @window.size.x
        height = @window.size.y
        rectangle = SF::RectangleShape.new(SF.vector2(width, height))
        rectangle.fill_color = SF::Color.new(0, 0, 0, @fade)
        @window.draw(rectangle)
      end

      if @fade >= 255
        @fading_out = false
        # TODO: need this?
        # draw # do a first draw of the new scene, because normal draw won't trigger
        @fading_in = true
      elsif @fade <= 0
        @fading_in = false
      end

      @fade += fade_speed if @fading_out
      @fade -= fade_speed if @fading_in
    end

    def fade_out
      @fading_out = true
    end

    def fading?
      @fading_out || @fading_in
    end

    def needs_update?
      !@paused && !fading?
    end

    def needs_redraw?
      true
    end

    abstract def enter
    abstract def leave
    abstract def update
    abstract def button_down(key : SF::Keyboard::Key)
    abstract def button_up(key : SF::Keyboard::Key)
  end
end
