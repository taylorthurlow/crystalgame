require "crsfml"
require "./scene"
require "./collider"
require "./tile/collider"

class Tile < Gosu::Image
  property scene : Scene
  property id : UInt32
  property? logic_class : Tile
  property sprite : SF::Sprite
  property name : String
  property x : UInt32
  property y : UInt32
  property colliders : Array(Collider) = [] of Collider

  def initialize(scene : Scene, id : UInt32 = nil, sprite_id : UInt32 = nil)
    # load metadata from previously loaded tile data given either an id or a
    # sprite id (only one of the two is necessary)
    metadata = Tile.metadata(id, sprite_id)
    raise "Encountered an unknown tile in map: #{id || sprite_id}" unless metadata

    @scene = scene
    @id = metadata["id"]
    @sprite_id = metadata["sprite_id"]
    @sprite_path = metadata["sprite_path"]
    @name = metadata["name"]
    @colliders = metadata["colliders"].map(&:clone)
    @colliders.each { |c| c.tile = self }
    @logic_class = metadata["class"]
    @sprite = Tile.load_sprite(@sprite_path, @sprite_id)
  end

  def self.metadata(id : UInt32, sprite_id : UInt32)
    raise "No ID supplied for metadata lookup." if id.nil? && sprite_id.nil?

    if id
      @@tile_data[id]
    elsif sprite_id
      Tile.find_tile_by_sprite_id(sprite_id)
    end
  end

  def pos_x
    @x * 16
  end

  def pos_y
    @y * 16
  end

  def interact
    # override this
    false
  end

  def draw(draw_x, draw_y)
    @sprite.draw(draw_x, draw_y, @colliders.empty? ? 0 : colliders_lowest_point) unless id.zero?
    # @colliders.each(&:draw_bounding_box) if $debugging
  end

  # Returns the pixel value of the lowest vertex of all colliders on the tile. Used
  # for determining which z-index to draw at.
  def colliders_lowest_point
    @colliders.map(&:lowest_point).max
  end

  def to_s
    "#{name} (#{self.class} SID: #{@sprite_id}) @ #{x}, #{y}"
  end

  # Load tile data from file, include id key as a value for convencience
  def self.load_tile_data(tileset_path)
    Tile.preset_class_vars
    @@data_files_loaded ||= [] of String
    return if @@data_files_loaded.include? tileset_path

    @@data_files_loaded << tileset_path
    parsed = JSON.parse(File.read(tileset_path))
    parsed["tiles"].each do |tile|
      properties = tile["properties"].to_h { |p| [p["name"], p["value"]] }
      colliders = if tile["objectgroup"]
                    tile["objectgroup"]["objects"].map { |c| Tile::Collider.new_from_json(c) }
                  else
                    [] of Tile::Collider
                  end

      @@tile_data[properties["game_id"]] = {
        "id"          => properties["game_id"],
        "name"        => properties["name"],
        "sprite_id"   => tile["id"],
        "sprite_path" => parsed["image"].gsub("../", ""),
        "colliders"   => colliders,
        "class"       => properties["class"],
      }
    end
  end

  def self.load_sprite(path, sprite_id)
    path ||= "assets/basictiles.png"

    unless @@tile_sprites.key? path
      @@tile_sprites[path] = Gosu::Image.load_tiles(path, 16, 16, retro: true)
    end

    @@tile_sprites[path][sprite_id]
  end

  # Get a hash with id keys and sprite_id values
  def self.tile_ids
    @@tile_data.map { |id, data| [id, [data["sprite"]]] }.to_h
  end

  def self.find_tile_by_sprite_id(sprite_id)
    tiles = @@tile_data.find { |_, d| d["sprite_id"] == sprite_id }

    tiles.any? ? tiles.fetch(1) : nil

    # @@tile_data.find { |_, d| d["sprite_id"] == sprite_id }&.fetch(1)
  end

  def self.tile_data
    @@tile_data
  end

  def self.preset_class_vars
    # @@tile_data ||= {} of String => Nillable
    # @@data_files_loaded ||= [] of String
    # @@tile_ids ||= Tile.tile_ids
    # @@tile_sprites ||= {}
  end
end
