
class Bi::Rainbow

  VELOCITY = 1
  @@rainbow = []

  # 0.0 to 1.0 HSV color circle.
  def self.at(angle)
    Bi::Rainbow::make_rainbow_table if @@rainbow.empty?
    @@rainbow[ (angle*256*6).to_i ]
  end

  def self.make_rainbow_table
    @@rainbow = []

    r, g, b = 255, 0, 0
    rv, gv, bv = 0, VELOCITY, 0
    (256*6).times{
      r += rv
      g += gv
      b += bv

      if r > 255
        r = 255
        rv = 0
        bv = -VELOCITY
      elsif r < 0
        r = 0
        rv = 0
        bv = VELOCITY
      elsif g > 255
        g = 255
        gv = 0
        rv = -VELOCITY
      elsif g < 0
        g = 0
        gv = 0
        rv = VELOCITY
      elsif b > 255
        b = 255
        bv = 0
        gv = -VELOCITY
      elsif b < 0
        b = 0
        bv = 0
        gv = VELOCITY
      end

      rgb = [r,g,b]
      @@rainbow << rgb
    }
    @@rainbow
  end
end

