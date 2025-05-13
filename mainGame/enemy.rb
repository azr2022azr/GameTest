require_relative "usefulFunctions"
class Enemy
  def initialize(name, x, y)
    @enhp = 1
    @enws = Random.rand(30..70)
    @endamage = 1
    @enxPos = x
    @enyPos = y
    @enname = name
    @enSize = 26
    @name = name
    @actionframe = "n0"
  end

  def getX
    return @enxPos
  end

  def getY
    return @enyPos
  end

  def damageHP(damage)
    @enhp -= damage
  end

  def getHP
    return @enhp
  end

  def getDamage
    return @endamage
  end

  def intX(val)
    @enxPos += val
  end

  def intY(val)
    @enyPos += val
  end

  def getsize
    return @enSize
  end

  def draw(playerx, playery)
    #Gosu::Image.new("C:/GameTest/textures/" + @name.to_s + @actionframe.to_s + ".png").draw_rot(@enxPos, @enyPos + 112, 1)
    Gosu::Image.new("C:/GameTest/textures/" + @name.to_s + "n0.png").draw_rot(@enxPos-playerx+160, @enyPos, 1)
  end

  def hitPlayer(playerx, playery)
    if @actionframe[0] == "a" && @actionframe[1].to_i >= 6
      @actionframe = "n0"
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
        @actionframe = "a0"
      end
    end

    if(@actionframe[0] == "a")
      @actionframe = "a" + (@actionframe[1].to_i + 1).to_s
    end

    if @enyPos > 224
      @enyPos = 224
    elsif @enyPos < 0
      @enyPos = 0
    end
  end
end