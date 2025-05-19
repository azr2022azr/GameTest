require_relative 'player'   
class Equipment 
  def initialize(rarity, name, type, backDiff, wType, mID = "") # type 1 = weapon, type 2 = armor, type 3 = acc
    @name = "-"
    @dps = 1
    @name = name
    @rarity = rarity
    @type = type
    @wType = wType
    #HPR, hp, ws, d%, dr
    @stats = [0,0,0,0,0]
    @valueList = [0.01, 1, 0.05, 1, 1]
    @slot = -1
    @majorid = mID
    @iddesc = ""

    if(rarity != 0 && @type == 3)
        for i in 1..rarity do
            rado = Random.rand(0..4)
            @stats[rado] += Random.rand(9..13)*@valueList[rado] * backDiff
        end
        @stats[4] = Math.sqrt(@stats[4])
    end

    if(@rarity >= 3 && @type == 3)
        random = Random.rand(1..12)
        if(random == 1)
            @majorid = "Shock Absorbers"
            @iddesc = "Parries refresh \ndash"
        elsif(random == 2)
            @majorid = "Flying Claw"
            @iddesc = "Dash does damage"
        elsif(random == 3)
            @majorid = "Weighted"
            @iddesc = "Attack speed \nslows, but you \ndo more damage"
        elsif(random == 4)
            @majorid = "Overdraw"
            @iddesc = "Attacks burn health \nand do more \ndamage"
        elsif(random == 5)
            @majorid = "Fury"
            @iddesc = "Attacks do more \ndamage the lower \nhealth"
        elsif(random == 6)
            @majorid = "AMR"
            @iddesc = "Bullets have more \nknockback"
        elsif(random == 7)
            @majorid = "Grapple"
            @iddesc = "Bullets pull enemies"
        elsif(random == 8)
            @majorid = "Akimbo"
            @iddesc = "Attack speed \nincreases, but you \ndo less damage"
        elsif(random == 9)
            @majorid = "Reap"
            @iddesc = "Kills refresh dash"
        elsif(random == 10)
            @majorid = "Blitz"
            @iddesc = "Hits grant \nspeed"
        elsif(random == 11)
            @majorid = "Pulse"
            @iddesc = "Do damage to \nnearby enemies"
        elsif(random == 12)
            @majorid = "Barrier"
            @iddesc = "Parries heal"
        end
    end

    if(@type == 1 && rarity != 0)
        @dps = (Random.new.rand(10..20) + (rarity * backDiff))
        @slot = Random.rand(1..2)
    end
end
    
def getRarity
    return @rarity
end

def getMajorID
    return @majorid
end

def getIDDESC
    return @iddesc
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
    