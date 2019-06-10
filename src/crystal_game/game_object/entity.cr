require "../game_object"
require "./entity/sounds"
require "./entity/graphics"
require "./entity/physics"

module CrystalGame
  class Entity < GameObject
    property physics : Entity::Physics
    property graphics : Entity::Graphics
    property sounds : Entity::Sounds

    def initialize(scene)
      super(scene)

      @physics = Entity::Physics.new(self, scene)
      @graphics = Entity::Graphics.new(self)
      @sounds = Entity::Sounds.new(self)
    end

    def pos_x
      @physics.pos_x
    end

    def pos_y
      @physics.pos_y
    end

    def x
      @physics.x
    end

    def y
      @physics.y
    end

    def direction
      @physics.direction
    end
  end
end
