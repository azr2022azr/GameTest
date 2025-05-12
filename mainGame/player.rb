require_relative 'equipment'
class Player 
  def initialize(name)
    @name = name
    @hp = 100
    @ws = 100
    @xPos = 0
    @yPos = 0
    @lives = 9
    @veloc = 0
    @spcap = @ws * 0.05
    @activity = "n0"
    @accelMod = 1.8

    @weapon1 = Equipment.new(1, "Default Dagger", 1, 1)
    @weapon2 = Equipment.new(0, "none", 1, 1)

    @armor = Equipment.new(0,"none", 2, 1)
  
    @accessory = [Equipment.new(0,"none", 3, 1)]
    
  end

  def showHealth 
    return @hp
  end

  def getWeapon1
      return @weapon1
  end

  def getWeapon2
      return @weapon2
  end

  def getArmor
      return @armor
  end

  def getAccessoryList
      return @accessory
  end

  def incrementX(inc)
    @xPos += inc
  end

  def incrementY(inc)
    @yPos += inc
  end

  def getX
    return @xPos
  end

  def getY
    return @yPos
  end

  def die
    @lives -= 1
    @name = name
    @hp = 100
    @ws = 100
    @xPos = 0
    @yPos = 0
    @veloc = 0
    @spcap = @ws * 0.05
    @activity = "n0"
    @accelMod = 1.8
    @lastpress = 0
  end

  def getlife
    return @lives
  end

  def tickPlayer
    if (Gosu.button_down? Gosu::KbW) && (Gosu.button_down? Gosu::KbD)
      if(@veloc == 0)
        @veloc = 0.5
      elsif @accelMod * @veloc > @spcap
        @veloc = @spcap
      elsif @veloc < @spcap
        @veloc = @accelMod * @veloc
      end
      @xPos += @veloc / Math.sqrt(2)
      @yPos -= @veloc / Math.sqrt(2)
      @lastpress = 1

    elsif (Gosu.button_down? Gosu::KbS) && (Gosu.button_down? Gosu::KbD)
      if(@veloc == 0)
        @veloc = 0.5
      elsif @accelMod * @veloc > @spcap
        @veloc = @spcap
      elsif @veloc < @spcap
        @veloc = @accelMod * @veloc
      end
      @xPos += @veloc / Math.sqrt(2)
      @yPos += @veloc / Math.sqrt(2)
      @lastpress = 2
    
    elsif (Gosu.button_down? Gosu::KbS) && (Gosu.button_down? Gosu::KbA)
      if(@veloc == 0)
        @veloc = 0.5
      elsif @accelMod * @veloc > @spcap
        @veloc = @spcap
      elsif @veloc < @spcap
        @veloc = @accelMod * @veloc
      end
      @xPos -= @veloc / Math.sqrt(2)
      @yPos += @veloc / Math.sqrt(2)
      @lastpress = 3
    
    elsif (Gosu.button_down? Gosu::KbW) && (Gosu.button_down? Gosu::KbA)
      if(@veloc == 0)
        @veloc = 0.5
      elsif @accelMod * @veloc > @spcap
        @veloc = @spcap
      elsif @veloc < @spcap
        @veloc = @accelMod * @veloc
      end
      @xPos -= @veloc / Math.sqrt(2)
      @yPos -= @veloc / Math.sqrt(2)
      @lastpress = 4

    elsif (Gosu.button_down? Gosu::KbW)
      if(@veloc == 0)
        @veloc = 0.5
      elsif @accelMod * @veloc > @spcap
        @veloc = @spcap
      elsif @veloc < @spcap
        @veloc = @accelMod * @veloc
      end
      @yPos -= @veloc
      @lastpress = 5
    
    elsif (Gosu.button_down? Gosu::KbS)
      if(@veloc == 0)
        @veloc = 0.5
      elsif @accelMod * @veloc > @spcap
        @veloc = @spcap
      elsif @veloc < @spcap
        @veloc = @accelMod * @veloc
      end
      @yPos += @veloc
      @lastpress = 6

    elsif (Gosu.button_down? Gosu::KbA)
      if(@veloc == 0)
        @veloc = 0.5
      elsif @accelMod * @veloc > @spcap
        @veloc = @spcap
      elsif @veloc < @spcap
        @veloc = @accelMod * @veloc
      end
      @xPos -= @veloc
      @lastpress = 7

    elsif (Gosu.button_down? Gosu::KbD)
      if(@veloc == 0)
        @veloc = 0.5
      elsif @accelMod * @veloc > @spcap
        @veloc = @spcap
      elsif @veloc < @spcap
        @veloc = @accelMod * @veloc
      end
      @xPos += @veloc
      @lastpress = 8
    
    else
      @veloc = @veloc/1.2
      if @veloc < 1
        @veloc = 0
        @lastpress = 0
      end

      if @lastpress == 1
        @xPos += @veloc / Math.sqrt(2)
        @yPos -= @veloc / Math.sqrt(2)
      elsif @lastpress == 2
        @xPos += @veloc / Math.sqrt(2)
        @yPos += @veloc / Math.sqrt(2)
      elsif @lastpress == 3
        @xPos -= @veloc / Math.sqrt(2)
        @yPos += @veloc / Math.sqrt(2)
      elsif @lastpress == 4
        @xPos += @veloc / Math.sqrt(2)
        @yPos -= @veloc / Math.sqrt(2)
      elsif @lastpress == 5
        @yPos -= @veloc
      elsif @lastpress == 6
        @yPos += @veloc
      elsif @lastpress == 7
        @xPos -= @veloc
      elsif @lastpress == 8
        @xPos += @veloc
      end
    end

    if @yPos > 112
      @yPos = 112
    elsif @yPos < -112
      @yPos = -112
    end

    puts (@xPos)
    puts (@yPos)
    puts (@veloc)
  end

  def draw
    Gosu::Image.new("C:/GameTest/textures/" + @activity.to_s + ".png").draw_rot(160, @yPos + 112, 1)
  end
end