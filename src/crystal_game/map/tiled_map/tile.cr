require "json"

require "./object"

module CrystalGame
  class Map
    class TiledMap
      class Tile
        getter id : Int32
        getter object_group_name : String | Nil
        getter objects : Array(Object) = [] of Object
        getter(properties) { [] of {name: String, type: String, value: String | Int32} }

        def initialize(tile_data : JSON::Any)
          @id = tile_data["id"].as_i

          if tile_data["objectgroup"]?
            @object_group_name = tile_data["objectgroup"]["name"].as_s

            tile_data["objectgroup"]["objects"].as_a.each do |object_data|
              objects << Object.new(object_data, false)
            end
          end

          tile_data["properties"].as_a.each do |property_data|
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
