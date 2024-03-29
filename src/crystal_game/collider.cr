module CrystalGame
  class Collider
    property width : UInt32
    property height : UInt32

    def initialize(width, height)
      @width = width
      @height = height
    end

    def center
      # override in subclass
    end

    def box
      # override in subclass
    end

    def lowest_point
      box.each_slice(2).to_a.map { |s| s[1] }.max
    end

    def draw_bounding_box
      # override in subclass
    end

    def to_s
      "Collider #{@width}x#{@height}"
    end

    def self.collision?(c1, c2)
      c1.pos_x < c2.pos_x + c2.width &&
        c1.pos_x + c1.width > c2.pos_x &&
        c1.pos_y < c2.pos_y + c2.height &&
        c1.pos_y + c1.height > c2.pos_y
    end
  end
end
