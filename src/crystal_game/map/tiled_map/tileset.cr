require "json"

require "./tile"

module CrystalGame
  class Map
    class TiledMap
      class Tileset
        getter json_path : String
        getter columns : Int32
        getter image_height : Int32
        getter image_width : Int32
        getter name : String
        getter tile_height : Int32
        getter tile_width : Int32
        getter tiles : Array(Tile) = [] of Tile

        def initialize(json_path : String)
          @json_path = json_path

          data = load_from_json

          @columns = data["columns"].as_i
          @image_height = data["imageheight"].as_i
          @image_width = data["imagewidth"].as_i
          @tile_height = data["tileheight"].as_i
          @tile_width = data["tilewidth"].as_i
          @name = data["name"].as_s

          data["tiles"].as_a.each do |tile_data|
            @tiles << Tile.new(tile_data)
          end
        end

        private def load_from_json : JSON::Any
          JSON.parse(File.read(@json_path))
        end
      end
    end
  end
end
