require "./game_object/component"

module CrystalGame
  class GameObject
    property object_pool
    property components : Array(Component) = [] of Component

    # property scene : Scene

    def initialize(scene)
      # @scene = scene
      # @object_pool = scene.object_pool
      # @object_pool.objects << self
    end

    def update
      @components.map(&:update)
    end

    def draw(viewport)
      @components.each { |c| c.draw(viewport) }
    end

    def removable?
      @removable
    end

    def mark_for_removal
      @removable = true
    end
  end
end
