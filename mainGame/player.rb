require_relative 'equipment'
require_relative "attack"
require_relative "parry"
require_relative "bullet"
class Player 
  def initialize(name)
    @name = name
    @xPos = 160
    @yPos = 112
    @lives = 9
    @veloc = 0
    @accelMod = 1.8
    @attacklist = []
    @parrylist = []
    @enemies = []
    @stats = [0.0, 100.0, 100, 0.0, 0.0]
    @base = [0.0, 100.0, 100.0, 0.0, 0.0]
    @phase = ["l", "n", "0"]
    @atkCooldown = 0
    @atkRate = 8
    @level = 1
    @xp = 90
    @sust = 0
    @dashCooldown = 0
    @atk2Cooldown = 0
    @atk2Rate = 8
    @basea2rate = 8
    @basearate = 8
    @dashTotalCooldown = 96
    @dashlength = 4
    @dashspeed = 3
    @atktype = 0
    @kb = 4
    @kbbase = 4
    @lasthits = 0.0

    @weapon1 = Equipment.new(1, "Default Dagger", 1, 1, 0)
    @weapon2 = Equipment.new(1, "gun", 1, 1, 2)
  
    @accessory = [Equipment.new(0,"bung", 3, 1, 1)]
    
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

  def setDash(val)
    @dashCooldown = val
  end

  def getWeapon2
      return @weapon2
  end

  def getArmor
      return @armor
  end

  def getMX(mx)
    @mouse_x = mx
  end

  def getMY(my)
    @mouse_y = my
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
    @xPos = 160
    @yPos = 112
    @lives = 9
    @veloc = 0
    @accelMod = 1.8
    @attacklist = []
    @parrylist = []
    @enemies = []
    @stats = [0.0, 100.0, 100, 0.0, 0.0]
    @base = [0.0, 100.0, 100.0, 0.0, 0.0]
    @phase = ["l", "n", "0"]
    @atkCooldown = 0
    @atkRate = 8
    @level = 1
    @xp = 0
    @sust = 0
    @dashCooldown = 0
    @atk2Cooldown = 0
    @atk2Rate = 8
    @basea2rate = 8
    @basearate = 8
    @dashTotalCooldown = 96
    @dashlength = 4
    @dashspeed = 3
    @atktype = 0
    @kb = 4
    @kbbase = 4
    @lasthits = 0.0

    temp = @accessory
    @accessory = [Equipment.new(0,"bung", 3, 1, 1)]

    for i in temp
      if(Random.rand(0..9) == 0)
        @accessory.push(i)
      end
    end

    @weapon1 = Equipment.new(1, "Default Dagger", 1, 1, 0)
    @weapon2 = Equipment.new(0, "none", 1, 1, 0)
    
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

  def getlife
    return @lives
  end

  def bumpEnemies(inp)
    @enemies = inp
  end

  def throwAttackList
    return @attacklist
  end

  def throwParryList
    return @parrylist
  end

  def giveHitCount(amt)
    @lasthits += amt
  end

  def heal(amt)
    @hp += amt
  end

  def tickPlayer
    fclaw = false
    basedamagemod = 100.0
    spdmod = 1.0
    disbitchHEAVY = false
    kbmod = 1.0
    burner = false
    flong = false
    brrrt = false
    borzoi = false
    bazoom = 1
    zoooom = false
    for i in @accessory do
      loc = 0
      for j in i.getStats
        @stats[loc] = @base[loc] + i.getStats[loc]
        loc += 1
      end
      if i.getMajorID == "Flying Claw"
        fclaw = true
      elsif i.getMajorID == "Weighted"
        disbitchHEAVY = true
      elsif i.getMajorID == "Overdraw"
        burner = true
      elsif i.getMajorID == "Fury"
        @stats[4] += ((@maxhp-@hp)*100)/@maxhp
      elsif i.getMajorID == "AMR"
        bazoom = 4
      elsif i.getMajorID == "Grapple"
        flong = true
      elsif i.getMajorID == "Akimbo"
        brrrt = true
      elsif i.getMajorID == "Pulse"
        borzoi = true
      elsif i.getMajorID == "Blitz"
        zoooom = true
      end
    end

    if(@hp +@stats[0]/24.0 < @maxhp)
      if(@stats[0]/24.0 < @maxhp/9600.0)
        @hp += @stats[0]/24.0
      else
        @hp += @maxhp/9600.0
      end
    else
      @hp = @maxhp
    end

    if @hp > @maxhp
      @hp=@maxhp
    end
    if disbitchHEAVY
      basedamagemod += 90
      spdmod += 1
      kbmod += 1
    end
    if brrrt
      basedamagemod /= 1.5
      spdmod /= 2
      kbmod /= 2
    end
    if burner
      basedamagemod += 100
    end
    if flong
      bazoom *= -4
    end
    @maxhp = @stats[1]
    @ws = @stats[2]
    if zoooom
      @ws += @lasthits*5
    end
    @spcap = @ws * 0.05
    @atkRate = @basearate*spdmod
    @atk2Rate = @basea2rate*spdmod
    @kb = @kbbase *kbmod
    @lasthits /= 1.05

    if borzoi
      for b in @enemies
        if (distance(@xPos, b.getX) < b.getsize + 32) &&(distance(@yPos, b.getY) < b.getsize + 32)
          if(@weapon1.getDPS > @weapon2.getDPS)
            b.damageHP((@weapon1.getDPS() *(@ws*0.00003))*0.01*basedamagemod)
            @lasthits += 0.1
          else
            b.damageHP((@weapon2.getDPS() *(@ws*0.00003))*0.01*basedamagemod)
            @lasthits += 0.1
          end
        end
      end
    end


    if @phase[1] == "n" || @phase[1] == "w"
      if (Gosu.button_down? Gosu::KbLeftShift) && (@dashCooldown == 0)
        @phase[1] = "d"
        @phase[2] = "0"

      elsif (Gosu.button_down? Gosu::MsLeft) && (@atkCooldown == 0)
        @phase[1] = "a"
        @phase[2] = "0"
        @useweapon = 1
      
      elsif (Gosu.button_down? Gosu::MsRight) && (@atk2Cooldown == 0)
        if(@weapon2.getname != "none")
          @phase[1] = "a"
          @phase[2] = "0"
          @useweapon = 2
        end

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
        @phase[2] = (@phase[2].to_i + 1).to_s
        @phase[1] = "w"

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
        @phase[2] = (@phase[2].to_i + 1).to_s
        @phase[1] = "w"
      
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
        @phase[2] = (@phase[2].to_i + 1).to_s
        @phase[1] = "w"
      
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
        @phase[2] = (@phase[2].to_i + 1).to_s
        @phase[1] = "w"

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
        @phase[2] = (@phase[2].to_i + 1).to_s
        @phase[1] = "w"
      
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
        @phase[2] = (@phase[2].to_i + 1).to_s
        @phase[1] = "w"

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
        @phase[2] = (@phase[2].to_i + 1).to_s
        @phase[1] = "w"

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
        @phase[2] = (@phase[2].to_i + 1).to_s
        @phase[1] = "w"
      
      else
        @veloc = @veloc/1.2
        if @veloc < 1
          @veloc = 0
          @lastpress = 0
          @phase[1] = "n"
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

      if(@phase[2].to_i >= 12)
        @phase[2] = "0"
      end
    
    elsif(@phase[1] == "d")
      if @lastpress == 1
        @xPos += @spcap * @dashspeed / Math.sqrt(2)
        @yPos -= @spcap * @dashspeed / Math.sqrt(2)
      elsif @lastpress == 2
        @xPos += @spcap * @dashspeed / Math.sqrt(2)
        @yPos += @spcap * @dashspeed / Math.sqrt(2)
      elsif @lastpress == 3
        @xPos -= @spcap * @dashspeed / Math.sqrt(2)
        @yPos += @spcap * @dashspeed / Math.sqrt(2)
      elsif @lastpress == 4
        @xPos += @spcap * @dashspeed / Math.sqrt(2)
        @yPos -= @spcap * @dashspeed / Math.sqrt(2)
      elsif @lastpress == 5
        @yPos -= @spcap * @dashspeed
      elsif @lastpress == 6
        @yPos += @spcap * @dashspeed
      elsif @lastpress == 7
        @xPos -= @spcap * @dashspeed
      elsif @lastpress == 8
        @xPos += @spcap * @dashspeed
      end

      if(@phase[2].to_i >= @dashlength)
        @phase[2] = "0"
        @phase[1] = "n"
        @dashCooldown = 1
      end
      @phase[2] = (@phase[2].to_i + 1).to_s
      if fclaw
        for b in @enemies do
          if (distance(@xPos, b.getX) < b.getsize + 16) &&(distance(@yPos, b.getY) < b.getsize + 16)
            if(@weapon1.getDPS > @weapon2.getDPS)
              b.damageHP((@weapon1.getDPS() *(@ws*0.03))*0.01*basedamagemod)
              b.getKnockBack(0,0)
              @lasthits += 1
            else
              b.damageHP((@weapon2.getDPS() *(@ws*0.03))*0.01*basedamagemod)
              b.getKnockBack(0,0)
              @lasthits += 1
            end
          end
        end
      end

    elsif(@phase[1] == "a")
      if(@phase[2] == "1")
        if @useweapon == 1
          if(@weapon1.getname != "none")
            @atktype = 1
            if @weapon1.getWeaponType == 0
              @attacklist.push(PlayerAttack.new(@xPos, @yPos, (@weapon1.getDPS * (1 + (0.01*@stats[3])) + @stats[4])*0.01*basedamagemod, @sust, @enemies, @accessory, @kb))
            elsif @weapon1.getWeaponType == 1
              @parrylist.push(PlayerParry.new(@xPos, @yPos, (@weapon1.getDPS * (1 + (0.01*@stats[3])) + @stats[4])*0.01*basedamagemod, @sust, @enemies, @accessory, @kb))
            elsif @weapon1.getWeaponType == 2
              @attacklist.push(PlayerGun.new(@xPos, @yPos, (@weapon1.getDPS* (1 + (0.01*@stats[3])) + @stats[4])*0.01*basedamagemod, @sust, @enemies, @mouse_x, @mouse_y, @accessory, @kb*bazoom))
            end
          end
        else
          if(@weapon2.getname != "none")
            @atktype = 2
            if @weapon2.getWeaponType == 0
              @attacklist.push(PlayerAttack.new(@xPos, @yPos, (@weapon2.getDPS * (1 + (0.01*@stats[3])) + @stats[4])*0.01*basedamagemod, @sust, @enemies, @accessory, @kb))
            elsif @weapon2.getWeaponType == 1
              @parrylist.push(PlayerParry.new(@xPos, @yPos, (@weapon2.getDPS * (1 + (0.01*@stats[3])) + @stats[4])*0.01*basedamagemod, @sust, @enemies, @accessory, @kb))
            elsif @weapon2.getWeaponType == 2
              @attacklist.push(PlayerGun.new(@xPos, @yPos, (@weapon2.getDPS* (1 + (0.01*@stats[3])) + @stats[4])*0.01*basedamagemod, @sust, @enemies, @mouse_x, @mouse_y, @accessory, @kb*bazoom))
            end
          end
        end
      end

      if(@phase[2] == "8")
        @phase[1] = "n"
        @phase[2] = "0"
        if burner
          @hp -= 0.05*@hp
        end
        if @atktype == 1
          @atkCooldown = 1
        elsif @atktype == 2
          @atk2Cooldown = 1
        end
      end
      @phase[2] = (@phase[2].to_i + 1).to_s
    end

    if @atkCooldown > 0
      @atkCooldown += 1
      if @atkCooldown == @atkRate
        @atkCooldown = 0
      end
    end

    if @atk2Cooldown > 0
      @atk2Cooldown += 1
      if @atk2Cooldown == @atk2Rate
        @atk2Cooldown = 0
      end
    end

    if @dashCooldown > 0
      @dashCooldown += 1
      if @dashCooldown == @dashTotalCooldown
        @dashCooldown = 0
      end
    end

    hh = 0
    for e in @attacklist
      e.tickAttack
      @lasthits += e.getpings
      if(e.kILLYOURSELF)
        @attacklist.delete_at(hh)
      end
      hh += 1
    end

    hh = 0
    for e in @parrylist
      e.tickParry
      @lasthits += e.getpings
      if(e.kILLYOURSELF)
        @parrylist.delete_at(hh)
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
    if @phase[1] == "w"
      Gosu::Image.new("C:/GameTest/textures/player/" + @phase[0].to_s + @phase[1].to_s + (@phase[2].to_i / 6).round(0).to_s + ".png").draw_rot(160, @yPos, 1)
    elsif @phase[1] == "d"
      Gosu::Image.new("C:/GameTest/textures/player/" + @phase[0].to_s + "w0.png").draw_rot(160, @yPos, 1)
    else
      Gosu::Image.new("C:/GameTest/textures/player/" + @phase[0].to_s + "n0.png").draw_rot(160, @yPos, 1)
    end

    if @dashCooldown == 0
      Gosu::Image.new("C:/GameTest/textures/dashon.png").draw_rot(24, 24, 1)
    else
      Gosu::Image.new("C:/GameTest/textures/dashoff.png").draw_rot(24, 24, 1)
    end
  end
end