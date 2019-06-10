require "./map/tiled_map"
require "./map/tiled_map/tileset"
require "./scene"

module CrystalGame
  class Map
    property tiled_map : TiledMap
    property tileset : TiledMap::Tileset
    property scene : Scene

    def initialize(map_json_path : String, tileset_path : String)
      @tiled_map = TiledMap.new(map_json_path)
      @tileset = TiledMap::Tileset.new(tileset_path)
    end
  end
end
