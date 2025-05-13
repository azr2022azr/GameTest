require_relative "enemy"
class PlayerAttack
  def initialize(x, y, damage, rotation, enemies)
    @rot = rotation
    @x = x
    @y = y
    @damage = damage
    @size = 8
    @image = Gosu::Image.new("C:/GameTest/textures/slash.png")
    @enem = enemies
    @ticks = 4
    @ticksalive = 0
    @enemies = []
  end

  def draw
    if(@rot == 1)
      @image.draw_rot(160+(@size/Math.sqrt(2)), @y-(@size/Math.sqrt(2)), 1, 315)
    elsif(@rot == 2)
      @image.draw_rot(160+(@size/Math.sqrt(2)), @y+(@size/Math.sqrt(2)), 1, 225)
    elsif(@rot == 3)
      @image.draw_rot(160-(@size/Math.sqrt(2)), @y+(@size/Math.sqrt(2)), 1, 135)
    elsif(@rot == 4)
      @image.draw_rot(160-(@size/Math.sqrt(2)), @y-(@size/Math.sqrt(2)), 1, 45)
    elsif(@rot == 5)
      @image.draw_rot(160, @y-(@size/Math.sqrt(2)), 1, 0)
    elsif(@rot == 6)
      @image.draw_rot(160, @y+(@size/Math.sqrt(2)), 1, 180)
    elsif(@rot == 7)
      @image.draw_rot(160-(@size/Math.sqrt(2)), @y, 1, 90)
    elsif(@rot == 8)
      @image.draw_rot(160+(@size/Math.sqrt(2)), @y, 1, 270)
    end
  end

  def tickAttack
    for enem in @enemies
      if(distance(@x, enem.enxPos) < @enemies.getsize + @size)
        @enemies.damageHP(@damage)
      end
    end
    @ticksalive += 1
  end

  def kILLYOURSELF
    if(@ticksalive >= @ticks)
      return true
    else
      return false
    end
  end
end