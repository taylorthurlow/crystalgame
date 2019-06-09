require "crsfml"

require "./crystalgame/game"

module CrystalGame
  def self.start
    game = Game.new

    game.run
  end
end
