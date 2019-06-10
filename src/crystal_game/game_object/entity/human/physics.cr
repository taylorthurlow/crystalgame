require "../../entity/physics"
require "../../entity/collider"
require "../../../game_object"
require "../../../scene"

module CrystalGame
  class Human
    class Physics < Entity::Physics
      def initialize(game_object : GameObject, scene : Scene)
        # Component.instance_method(:initialize).bind(self).call(game_object)

        @scene = scene
        @pos_x = scene.spawn[0] * 16 - 8
        @pos_y = scene.spawn[1] * 16 - 8
        @speed = 0.0
        @direction = :south
        @stopped_moving = true
        @colliders = [Entity::Collider.new(10, 7, self)]
      end
    end
  end
end
