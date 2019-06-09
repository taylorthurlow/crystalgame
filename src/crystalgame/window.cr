require "./states/game_state"

module CrystalGame
  class Window < SF::RenderWindow
    property! :state

    def initialize(width : Int16, height : Int16)
      video_mode = SF::VideoMode.new(width, height)
      super(video_mode, "Crystal Game")

      @state = MenuState.new(self)

      self.vertical_sync_enabled = true
    end

    def update
      @state.update if @state.needs_update?
    end
  end
end
