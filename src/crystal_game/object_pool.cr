require "./game_object/component"

module CrystalGame
  class ObjectPool
    property objects : Array(Component) = [] of Component

    # property map : Map

    # def initialize(map : Map)
    def initialize
    end

    # def nearby(object, max_distance)
    #   @objects.select do |obj|
    #     distance = Utils.distance_between(obj.pos_x, obj.pos_y, object.pos_x, object.pos_y)
    #     obj != object && distance < max_distance
    #   end
    # end

    # def player
    #   @objects.find { |o| o.is_a? Player }
    # end
  end
end
