require_relative "enemy"
class PlayerAttack
  def initialize(x, y, damage, rotation, enemies)
    @rot = rotation
    @x = x
    @y = y
    @basex = x
    @basey = y
    @damage = damage
    @size = 16
    @image = Gosu::Image.new("C:/GameTest/textures/slash/a0.png")
    @ticks = 8
    @ticksalive = 0
    @enemies = enemies
    @kbx = 0
    @kby = 0
    @kb = 4
  end

  def draw
    zone = @size + 16
    @x = @basex
    @y = @basey
    @image = Gosu::Image.new("C:/GameTest/textures/slash/a" +@ticksalive.to_s + ".png")
    if(@rot == 1)
      
      @image.draw_rot(160+(zone/Math.sqrt(2)), @y-(zone/Math.sqrt(2)), 1, 45)
      @kbx = @kb/Math.sqrt(2)
      @x = 26/Math.sqrt(2) + @basex
      @kby = -1*@kb/Math.sqrt(2)
      @y = -1*26/Math.sqrt(2) + @basey
    elsif(@rot == 2)
      
      @image.draw_rot(160+(zone/Math.sqrt(2)), @y+(zone/Math.sqrt(2)), 1, 135)
      @kbx = @kb/Math.sqrt(2)
      @kby = @kb/Math.sqrt(2)
      @x = 26/Math.sqrt(2) + @basex
      @y = 26/Math.sqrt(2) + @basey
    elsif(@rot == 3)
      
      @image.draw_rot(160-(zone/Math.sqrt(2)), @y+(zone/Math.sqrt(2)), 1, 225)
      @kbx = -1*@kb/Math.sqrt(2)
      @kby = @kb/Math.sqrt(2)
      @x = -1*26/Math.sqrt(2) + @basex
      @y = 26/Math.sqrt(2) + @basey
    elsif(@rot == 4)
      
      @image.draw_rot(160-(zone/Math.sqrt(2)), @y-(zone/Math.sqrt(2)), 1, 315)
      @kbx = -1*@kb/Math.sqrt(2)
      @kby = -1*@kb/Math.sqrt(2)
      @y = -1*26/Math.sqrt(2) + @basey
      @x = -1*26/Math.sqrt(2) + @basex
    elsif(@rot == 5)
      
      @image.draw_rot(160, @y-(zone/Math.sqrt(2)), 1, 0)
      @kby = -1*@kb
      @y = -1*26 + @basey
      @kbx = 0
    elsif(@rot == 6)
      
      @image.draw_rot(160, @y+(zone/Math.sqrt(2)), 1, 180)
      @kby = @kb
      @y = 26 + @basey
      @kbx = 0
    elsif(@rot == 7)
      @image.draw_rot(160-(zone/Math.sqrt(2)), @y, 1, 270)
      @kbx = -1*@kb
      @kby = 0
      @x = -1*26 + @basex
    elsif(@rot == 8)
      @image.draw_rot(160+(zone/Math.sqrt(2)), @y, 1, 90)
      @kbx = @kb
      @kby = 0
      @x = 26 + @basex
    end
  end

  def tickAttack
    for enem in @enemies
      if (distance(@x, enem.getX) < @enemies.length + @size) &&(distance(@y, enem.getY) < @enemies.length + @size)
        enem.damageHP(@damage)
        enem.getKnockBack(@kbx, @kby)
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