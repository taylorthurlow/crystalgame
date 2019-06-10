require "../entity"
require "./human/physics"
require "./human/graphics"
require "../entity/sounds"
require "../../scene"
require "../component"

module CrystalGame
  class Human < Entity
    property input : Component # PlayerInput?

    def initialize(scene : Scene, input : Component)
      # GameObject.instance_method(:initialize).bind(self).call(scene.object_pool)

      @input = input
      @input.control(self)
      @physics = Human::Physics.new(self, scene.object_pool)
      @graphics = Human::Graphics.new(self)
      @sounds = Entity::Sounds.new(self)
    end

    def to_s
      "Player: #{x}, #{y} (#{pos_x}, #{pos_y}), Direction: #{direction}"
    end
  end
end
