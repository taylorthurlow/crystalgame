require "json"

module CrystalGame
  class Map
    class TiledMap
      class Object
        getter id : Int32
        getter name : String
        getter type : String
        getter height : Int32
        getter width : Int32
        getter origin_x : Int32
        getter origin_y : Int32
        getter visible : Bool
        getter rotation : Int32
        getter(properties) { [] of {name: String, type: String, value: String | Int32} }

        def initialize(object_data : JSON::Any, include_properties : Bool = false)
          @id = object_data["id"].as_i
          @name = object_data["name"].as_s
          @type = object_data["type"].as_s
          @height = object_data["height"].as_i
          @width = object_data["width"].as_i
          @origin_x = object_data["x"].as_i
          @origin_y = object_data["y"].as_i
          @visible = object_data["visible"].as_bool
          @rotation = object_data["rotation"].as_i

          return unless include_properties

          object_data["properties"].as_a.each do |property_data|
            value = property_data["value"].as_i?
            value = property_data["value"].as_s unless value

            properties << {
              name:  property_data["name"].as_s,
              type:  property_data["type"].as_s,
              value: value,
            }
          end
        end
      end
    end
  end
end
