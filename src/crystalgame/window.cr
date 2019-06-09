require "./states/game_state"

module CrystalGame
  class Window < SF::RenderWindow
    property! :state
    getter! font : SF::Font

    def initialize(width : Int16, height : Int16)
      video_mode = SF::VideoMode.new(width, height)

      settings = SF::ContextSettings.new(depth: 24) # , antialiasing: 8)

      super(video_mode, "Crystal Game", settings: settings)

      @state = MenuState.new(self)
      @font = SF::Font.from_file("src/assets/fonts/Retron2000.ttf")

      self.vertical_sync_enabled = true
    end

    def update
      @state.update if @state.needs_update?
    end

    def width
      size.x
    end

    def height
      size.y
    end
  end
end
