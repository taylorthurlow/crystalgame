require "crsfml"

module CrystalGame
  def self.run
    window = SF::RenderWindow.new(SF::VideoMode.new(800, 600), "Crystal Game")

    while window.open?
      while event = window.poll_event
        window.close if event.is_a? SF::Event::Closed
      end
    end
  end
end
