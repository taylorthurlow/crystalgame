module CrystalGame
  class Camera
    property pos_x : Int32
    property pos_y : Int32
    property zoom : Int16

    def target=(target)
      @target = target
      @pos_x = target.pos_x
      @pos_y = target.pos_y
      @zoom = 2
    end

    # def update
    #   shift = Utils.adjust_speed(@target.physics.speed).round
    #   @pos_x += shift if @pos_x < @target.pos_x - $window.width / 6 / @zoom
    #   @pos_x -= shift if @pos_x > @target.pos_x + $window.width / 6 / @zoom
    #   @pos_y += shift if @pos_y < @target.pos_y - $window.height / 6 / @zoom
    #   @pos_y -= shift if @pos_y > @target.pos_y + $window.height / 6 / @zoom
    # end

    # def viewport
    #   x0 = @pos_x - ($window.width / 2)  / @zoom
    #   x1 = @pos_x + ($window.width / 2)  / @zoom
    #   y0 = @pos_y - ($window.height / 2) / @zoom
    #   y1 = @pos_y + ($window.height / 2) / @zoom

    #   [x0, x1, y0, y1]
    # end

    # def to_s
    #   "#{pos_x}, #{pos_y} (#{@zoom}x)"
    # end
  end
end
