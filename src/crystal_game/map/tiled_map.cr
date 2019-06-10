require "json"

require "./tiled_map/layer"

module CrystalGame
  class Map
    class TiledMap
      getter json_path : String
      getter height : Int32
      getter width : Int32
      getter tile_height : Int32
      getter tile_width : Int32
      getter layers : Array(Layer) = [] of Layer

      def initialize(json_path : String)
        @json_path = json_path

        data = load_from_json

        @height = data["height"].as_i
        @width = data["width"].as_i
        @tile_height = data["tileheight"].as_i
        @tile_width = data["tilewidth"].as_i

        data["layers"].as_a.each do |layer_data|
          @layers << Layer.new(layer_data)
        end
      end

      private def load_from_json : JSON::Any
        JSON.parse(File.read(@json_path))
      end
    end
  end
end
