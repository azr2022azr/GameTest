require_relative "enemy"
require_relative "equipment"
class PlayerGun
  def initialize(x, y, damage, rotation, enemies, tx, ty, gear, knock)
    @rot = rotation
    @x = x
    @y = y
    @basex = x
    @basey = y
    @damage = damage
    @size = 16
    @image = Gosu::Image.new("C:/GameTest/textures/pewpew.png")
    @ticks = 2
    @ticksalive = 0
    @enemies = enemies
    @kbx = 0
    @kby = 0
    @kb = knock
    @targx = tx
    @pings = 0
    @angle = 0
    @targy = ty
    @gear = gear
  end

  def draw
    @x = @basex
    @y = @basey
    @image = Gosu::Image.new("C:/GameTest/textures/pewpew.png")
    @angle = Math.atan2(@targy-@y, @targx - 160)
    @image.draw_rot(160+250*Math.cos(@angle), @y+250*Math.sin(@angle), 1, @angle*(180.0/Math::PI))
  end

  def tickAttack
    for enem in @enemies
      if (Math.atan2(enem.getY - @y, enem.getX - @x)*(180.0/Math::PI) - @angle*(180.0/Math::PI)).abs < 5
        enem.damageHP(@damage)
        @pings += 1
        enem.getKnockBack(@kb*0.25*Math.cos(@angle), @kb*0.25*Math.sin(@angle))
      end
    end
    @ticksalive += 1
  end

  def getpings
    return @pings
  end

  def kILLYOURSELF
    if(@ticksalive >= @ticks)
      return true
    else
      return false
    end
  end
end