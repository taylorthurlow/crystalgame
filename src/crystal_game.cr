require "crsfml"

require "./crystal_game/**"

module CrystalGame
  def self.start
    Game.new.run
  end
end
