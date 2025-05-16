require_relative 'player'   
class Equipment 
  def initialize(rarity, name, type, backDiff, wType) # type 1 = weapon, type 2 = armor, type 3 = acc
    @name = "-"
    @dps = 1
    @name = name
    @rarity = rarity
    @type = type
    @wType = type
    #HPR, hp, ws, d%, dr
    @stats = [0,0,0,0,0]
    @valueList = [0.1, 1, 0.5, 1, 1]
    @slot = -1

    if(rarity != 0 && @type == 3)
        for i in 1..rarity do
            rado = Random.rand(0..4)
            @stats[rado] += Random.rand(9..13)*@valueList[rado] * backDiff
        end
    end
    if(@type == 1)
        @dps = (Random.new.rand(20..40) + (rarity * 10)) + (backDiff*3)
        @slot = Random.rand(1..2)
    end
end
    
def getRarity
    return @rarity
end

def getDPS
    return @dps
end

def getWeaponType
    return @wType
end

def getslot
    return @slot
end

def getStats
    return @stats
end

def getType
    return @type
end

def getname
    return @name
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
    