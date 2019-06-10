require "json"

require "./object"

module CrystalGame
  class Map
    class TiledMap
      class Layer
        getter id : Int32
        getter name : String
        getter type : String
        getter visible : Bool
        getter tile_ids : Array(Int32) = [] of Int32
        getter height : Int32
        getter width : Int32
        getter origin_x : Int32
        getter origin_y : Int32
        getter objects : Array(Object) = [] of Object

        def initialize(layer_data : JSON::Any)
          @id = layer_data["id"].as_i
          @name = layer_data["name"].as_s
          @type = layer_data["type"].as_s
          @visible = layer_data["visible"].as_bool
          @origin_x = layer_data["x"].as_i
          @origin_y = layer_data["y"].as_i

          case @type
          when "tilelayer"
            @height = layer_data["height"].as_i
            @width = layer_data["width"].as_i

            layer_data["data"].as_a.each do |tile_id|
              tile_ids << tile_id.as_i
            end
          when "objectlayer"
            @height, @width = 0, 0

            layer_data["objects"].as_a.each do |object_data|
              @objects << Object.new(object_data)
            end
          else
            @height, @width = 0, 0
          end
        end
      end
    end
  end
end
