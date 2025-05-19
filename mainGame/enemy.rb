require_relative "usefulFunctions"
class Enemy
  def initialize(name, x, y, backdiff)
    @diff = backdiff
    @enhp = 150 + Random.rand(30..70) * (1+(@diff/2))
    @enws = 10 + Random.rand(5..20) * (1+(@diff/20))
    @endamage = 2 * (1+(@diff/30))
    @enxPos = x
    @enyPos = y
    @enname = name
    @enSize = 26
    @name = name
    @actionframe = ["n", "0", "l"]
    @kbex = 0
    @kbey = 0
    @invuln = 0
  end

  def getX
    return @enxPos
  end

  def getY
    return @enyPos
  end

  def damageHP(damage)
    if @invuln == 0
      @enhp -= damage
    end
  end

  def getHP
    return @enhp
  end

  def getKnockBack(momentx, momenty)
    if @invuln == 0
      @actionframe[0] = "k"
      @actionframe[1] = "0"
      @actionframe[2] = "l"
      @kbex = momentx
      @kbey = momenty
      @invuln = 1
    end
  end

  def getDamage
    return @endamage
  end

  def intX(val)
    @enxPos += val
  end

  def getPhase
    return @actionframe
  end

  def setPhase(pos, val)
    @actionframe[pos] = val
  end

  def intY(val)
    @enyPos += val
  end

  def getsize
    return @enSize
  end

  def draw(playerx, playery)
    #if playerx > @enxPos directional IMPORTANT
    #Gosu::Image.new("C:/GameTest/textures/" + @name.to_s + @actionframe.to_s + ".png").draw_rot(@enxPos, @enyPos + 112, 1)
    if(@actionframe[0] != "k")
      Gosu::Image.new("C:/GameTest/textures/enemy/" + @name.to_s + @actionframe[0].to_s + (@actionframe[1].to_i/6).to_s + @actionframe[2].to_s + ".png").draw_rot(@enxPos-playerx+160, @enyPos, 2)
    else
      Gosu::Image.new("C:/GameTest/textures/enemy/basica0" + @actionframe[2].to_s + ".png").draw_rot(@enxPos-playerx+160, @enyPos, 2)
    end
  end

  def hitPlayer(playerx, playery)
    if @actionframe[0] == "a" && @actionframe[1].to_i >= 18
      @actionframe[0] = "n"
      @actionframe[1] = "0"
      if(distance(playerx, @enxPos) < @enSize) && (distance(playery, @enyPos) < @enSize)
        return true
      end
    end
    return false
  end

  def tickEnemy(playerx, playery)
    if(@actionframe[0] == "n" || @actionframe[0] == "m")
      if (distance(playerx, @enxPos) > @enSize/2) || (distance(playery, @enyPos) > @enSize/2)
        temp = Math.sqrt((playerx-@enxPos)**2 + (playery-@enyPos)**2)
        if(temp == 0)
          temp = 0.001
        end
        @enxPos += (playerx-@enxPos)/temp *0.05*@enws
        @enyPos += (playery-@enyPos)/temp *0.05*@enws
      end
      if(distance(playerx, @enxPos) < @enSize/1.5) && (distance(playery, @enyPos) < @enSize/1.5)
        @actionframe[0] = "a"
        @actionframe[1] = "0"
      end
    end

    if(@actionframe[0] == "a")
      @actionframe[1] = (@actionframe[1].to_i + 1).to_s
    
    elsif @actionframe[0] == "k"
      if((@actionframe[1].to_i) >= 24)
        @actionframe[0] = "n"
        @actionframe[1] = "0"
      else
        @actionframe[1] = (@actionframe[1].to_i + 1).to_s
        @enxPos += @kbex
        @enyPos += @kbey
        @kbex /= 1.1
        @kbey /= 1.1
      end
    end

    if(@invuln > 0)
      if(@invuln > 12)
        @invuln = 0
      else
        @invuln += 1
      end
    end

    if(playerx > @enxPos)
      @actionframe[2] = "r"
    else
      @actionframe[2] = "l"
    end

    if @enyPos > 224
      @enyPos = 224
    elsif @enyPos < 0
      @enyPos = 0
    end
  end
end


class Rat < Enemy
  def initialize(name, x, y, backdiff)
    @diff = backdiff
    @enhp = (150 + Random.rand(30..70) * (1+(@diff/2)))/3
    @enws = (10 + Random.rand(10..25) * (1+(@diff/20)))*4
    @endamage = (2 * (1+(@diff/30)))*3
    @enxPos = x
    @enyPos = y
    @enname = name
    @enSize = 26
    @name = name
    @actionframe = ["n", "0", "l"]
    @kbex = 0
    @kbey = 0
    @invuln = 0
  end

  def draw(playerx, playery)
    #if playerx > @enxPos directional IMPORTANT
    #Gosu::Image.new("C:/GameTest/textures/" + @name.to_s + @actionframe.to_s + ".png").draw_rot(@enxPos, @enyPos + 112, 1)
    if(@actionframe[0] != "k")
      Gosu::Image.new("C:/GameTest/textures/enemy/rat" + @actionframe[0].to_s + (@actionframe[1].to_i/6).to_s + @actionframe[2].to_s + ".png").draw_rot(@enxPos-playerx+160, @enyPos, 1)
    else
      Gosu::Image.new("C:/GameTest/textures/enemy/rata0" + @actionframe[2].to_s + ".png").draw_rot(@enxPos-playerx+160, @enyPos, 1)
    end
  end

  def getKnockBack(momentx, momenty)
    if @invuln == 0 && (@actionframe[0] == "a" || @actionframe[0] == "k")
      @actionframe[0] = "k"
      @actionframe[1] = "0"
      @actionframe[2] = "l"
      @kbex = momentx
      @kbey = momenty
      @invuln = 1
    end
  end

  def damageHP(damage)
    if @invuln == 0 && (@actionframe[0] == "a" || @actionframe[0] == "k")
      @enhp -= damage
    end
  end
end