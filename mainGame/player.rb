require_relative 'equipment'
require_relative "attack"
class Player 
  def initialize(name)
    @name = name
    @xPos = 0
    @yPos = 0
    @lives = 9
    @veloc = 0
    @accelMod = 1.8
    @attacklist = []
    @enemies = []
    @stats = [0, 100, 100, 0, 0]
    @base = [0, 100, 100, 0, 0]
    @phase = "ln0"
    @atkCooldown = 0
    @atkRate = 8
    @level = 1
    @xp = 90
    @sust = 0

    @weapon1 = Equipment.new(1, "Default Dagger", 1, 1)
    @weapon2 = Equipment.new(0, "none", 1, 1)

    @armor = Equipment.new(0,"none", 2, 1)
  
    @accessory = [Equipment.new(0,"none", 3, 1)]

    for i in @accessory do
      loc = 0
      for j in i.getStats
        @stats[loc] += i.getStats[loc]
        loc += 1
      end
    end

    @hp = @stats[1]
    @maxhp = @stats[1]
    @ws = @stats[2]
    @spcap = @ws * 0.05
  end

  def showHealth 
    return @hp
  end

  def giveXP(val)
    @xp += val
  end

  def showXP
    return @xp
  end

  def levelUp
    @level += 1
  end

  def getMaxHP
    return @maxhp
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

  def damagePla(dam)
    @hp -= dam
  end

  def giveAcc(acc)
    @accessory.push(acc)
  end

  def setWep(wep, slot)
    if(slot == 1)
      @weapon1 = wep
    else
      @weapon2 = wep
    end
  end

  def die
    @lives -= 1
    @hp = 100
    @maxhp = 100
    @ws = 100
    @xPos = 0
    @yPos = 0
    @veloc = 0
    @spcap = @ws * 0.05
    @accelMod = 1.8
    @lastpress = 0
    @attacklist = []
    @sust = 0
    @enemies = []
    @phase = "ln0" #direction, action, frame
    @atkCooldown = 0
    @atkRate = 4
  end

  def getlife
    return @lives
  end

  def bumpEnemies(inp)
    @enemies = inp
  end

  def throwAttackList
    return @attacklist
  end

  def tickPlayer
    for i in @accessory do
      loc = 0
      for j in i.getStats
        @stats[loc] = @base[loc] + i.getStats[loc]
        loc += 1
      end
    end

    if(@hp +@stats[0]/24 < @maxhp)
      @hp += @stats[0]/24
    else
      @hp = @maxhp
    end
    @maxhp = @stats[1]
    @ws = @stats[2]
    @spcap = @ws * 0.05

    if @phase[1] == "n" || @phase[1] == "m"
      if (Gosu.button_down? Gosu::MsLeft) && (@atkCooldown == 0)
        @phase[1] = "a"
        @phase[2] = "0"

      elsif (Gosu.button_down? Gosu::KbW) && (Gosu.button_down? Gosu::KbD)
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
        @sust = 1
        @phase[0] = "r"

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
        @sust = 2
        @phase[0] = "r"
      
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
        @sust = 3
        @phase[0] = "l"
      
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
        @sust = 4
        @phase[0] = "l"

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
        @sust = 5
        @phase[0] = "u"
      
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
        @sust = 6
        @phase[0] = "d"

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
        @sust = 7
        @phase[0] = "l"

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
        @sust = 8
        @phase[0] = "r"
      
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

    elsif(@phase[1] == "a")
      if(@phase[2] == "1")
        @attacklist.push(PlayerAttack.new(@xPos, @yPos, @weapon1.getDPS * (1 + (0.01*@stats[3])) + @stats[4], @sust, @enemies))
      end
      if(@phase[2] == "8")
        @phase[1] = "n"
        @phase[2] = "0"
        @atkCooldown = 1
      end
      @phase[2] = (@phase[2].to_i + 1).to_s
    end

    if @atkCooldown > 0
      @atkCooldown += 1
      if @atkCooldown == @atkRate
        @atkCooldown = 0
      end
    end


    hh = 0
    for e in @attacklist
      e.tickAttack
      if(e.kILLYOURSELF)
        @attacklist.delete_at(hh)
      end
      hh += 1
    end

    if @yPos > 224
      @yPos = 224
    elsif @yPos < 0
      @yPos = 0
    end
  end

  def draw
    Gosu::Image.new("C:/GameTest/textures/player/" + @phase[0].to_s + "n0.png").draw_rot(160, @yPos, 1)
  end
end