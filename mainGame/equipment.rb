require_relative 'player'   
class Equipment 
  def initialize(rarity, name, type, backDiff) # type 1 = weapon, type 2 = armor, type 3 = acc
      @name = "-"
      @dps = 0
      @mID = false #change later
      @id1 = "-"
      @idcount1 = 0
      @id2 = "-" # common has 2 ids
      @idcount2 = 0
      @id3 = "-" # rare has 3 ids
      @idcount3 = 0
      @id4 = "-" # epic has 4 ids
      @idcount4 = 0
  
      @idList = ["Health Regen", "Health", "Walk Speed", "Damage %", "Damage Raw"]
      @valueList = [10, 100, 20, 10, 10]
      @length = @idList.size
      @size = @length.to_i
      if (rarity == 4)
          @rand = Random.new.rand(0..@size-1)
          @id1 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 11 / 10)..(@valueList[@rand] * 13 / 10))
          @rand = Random.new.rand(0..@size-1)
          @id2 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 11 / 10)..(@valueList[@rand] * 13 / 10))
          @rand = Random.new.rand(0..@size-1)
          @id3 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 11 / 10)..(@valueList[@rand] * 13 / 10))
          @rand = Random.new.rand(0..@size-1)
          @id4 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 11 / 10)..(@valueList[@rand] * 13 / 10))
          
      elsif (rarity == 3)
          @rand = Random.new.rand(0..@size-1)
          @id1 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 9 / 10)..(@valueList[@rand] * 11 / 10))
          @rand = Random.new.rand(0..@size-1)
          @id2 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 9 / 10)..(@valueList[@rand] * 11 / 10))
          @rand = Random.new.rand(0..@size-1)
          @id3 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 9 / 10)..(@valueList[@rand] * 11 / 10))
          @rand = Random.new.rand(0..@size-1)
          @id4 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 9 / 10)..(@valueList[@rand] * 11 / 10))

      elsif (rarity == 2)
          @rand = Random.new.rand(0..@size-1)
          @id1 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 9 / 10)..(@valueList[@rand] * 11 / 10))
          @rand = Random.new.rand(0..@size-1)
          @id2 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 9 / 10)..(@valueList[@rand] * 11 / 10))
          @rand = Random.new.rand(0..@size-1)
          @id3 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 9 / 10)..(@valueList[@rand] * 11 / 10))

      elsif (rarity == 1)
          @rand =  Random.new.rand(0..@size-1)
          @id1 = @idList[@rand]
          @idcount1 = Random.new.rand((@valueList[@rand] * 9 / 10)..(@valueList[@rand] * 11 / 10))
          @rand =  Random.new.rand(0..@size-1)
          @id2 = @idList[@rand]
          @idcount2 = Random.new.rand((@valueList[@rand] * 9 / 10)..(@valueList[@rand] * 11 / 10))
      end
    
      @name = name
      @rarity = rarity
      @type = type
      if(rarity != 0)        
          @dps = (Random.new.rand(20..40) + (rarity * 10)) * backDiff
      end
  end
    
  def getRarity
      return @rarity
  end
    
  def getID1
      return @id1
  end
  def getID2
      return @id2
  end
  def getID3
      return @id3
  end
  def getID4
      return @id4
  end
  def getIDC1
      return @idcount1
  end
  def getIDC2
      return @idcount2
  end
  def getIDC3
      return @idcount3
  end
  def getIDC4
      return @idcount4
  end
  def getDPS
      return @dps
  end
=begin
    def getDPS
        if getID1 == "Damage %"
            puts "detected damage id"
            @newDps = @dps.to_f * (1 + getIDC1 / 100)
            puts "idc1 is:"
            puts (1 + (getIDC1 / 100.0))
            puts "newdps is"
            puts @newDps
            @dps = @newDps.to_i
        end
        if getID2 == "Damage %"
            puts "detected damage id"
            puts (1+ (getIDC2 / 100.0))
            @newDps = @dps.to_f * (1+ getIDC2 / 100)
            puts "idc2 is:"
            puts getIDC2
            puts "newdps is"
            puts @newDps
            @dps = @newDps.to_i
        end
        if getID3 == "Damage %"
            @newDps = @dps * (1+getIDC3 / 100)
            @dps = @newDps.to_i
        end
        if getID4 == "Damage %"
            @newDps = @dps * (1+getIDC4 / 100)
            @dps = @newDps.to_i
        end
        return @dps
    end
=end
    
end
    