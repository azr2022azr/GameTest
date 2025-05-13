require_relative "usefulFunctions"
class Enemy
  def initialize(name, x, y)
    @enhp = 1
    @enws = 50
    @endamage = 1
    @enxPos = x
    @enyPos = y
    @enname = name
    @enxSize = 1
    @enySize = 1
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

  def draw(playerx, playery)
    #Gosu::Image.new("C:/GameTest/textures/" + @name.to_s + @actionframe.to_s + ".png").draw_rot(@enxPos, @enyPos + 112, 1)
    Gosu::Image.new("C:/GameTest/textures/" + @name.to_s + "n0.png").draw_rot(@enxPos-playerx, @enyPos + 112, 1)
  end

  def hitPlayer(playerx, playery)
    if @actionframe[0] == "a" && @actionframe[1] == 6
      @actionframe = "n0"
      if(distance(playerx, @enxPos) < @enxSize) && (distance(playery, @enyPos) < @enySize)
        return true
      end
    end
    return false
  end

  def tickEnemy(playerx, playery)
    if(@actionframe[0] == "n" || @actionframe[0] == "m")
      if (distance(playerx, @enxPos) > @enxSize/2) && (distance(playery, @enyPos) > @enySize/2)
        if (playerx-@enxPos).abs() > 0.1*@enws
          @enxPos += (playerx-@enxPos)/((playerx-@enxPos).abs()) * 0.1* @enws / Math.sqrt(2)
        else
          @enxPos = playerx
        end
        if (playery-@enyPos).abs() > 0.1*@enws
          @enyPos -= (playery-@enyPos)/((playery-@enyPos).abs()) * 0.1* @enws / Math.sqrt(2)
        else
          @enyPos = playery
        end
      elsif distance(playerx, @enxPos) > @enxSize/2
        if (playerx-@enxPos).abs() > 0.1*@enws
          @enxPos += (playerx-@enxPos)/((playerx-@enxPos).abs()) * 0.1* @enws
        else
          @enxPos = playerx
        end
      elsif distance(playery, @enyPos) > @enySize/2
        if (playery-@enyPos).abs() > 0.1*@enws
          @enyPos -= (playery-@enyPos)/((playery-@enyPos).abs()) * 0.1* @enws
        else
          @enyPos = playery
        end
      end
    end
    if(distance(playerx, @enxPos) < @enxSize) && (distance(playery, @enyPos) < @enySize)
      @actionframe = "a" + (@actionframe[1].to_i + 1).to_s
    end


    if @enyPos > 112
      @enyPos = 112
    elsif @enyPos < -112
      @enyPos = -112
    end
  end
end