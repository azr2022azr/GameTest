#Import Gosu. Press f5 to update code after edits
require 'gosu'
require_relative 'usefulFunctions'
require_relative "player"
require_relative "enemy"
require_relative "equipment"
require_relative "parry"
require_relative "bullet"

#gamephase info
#1 = title screen. 2 = game. 3 = info. Every 4th will be black transfer screen to /4. ex 4 -> 1, 8 -> 2
#5 = die, 6 = select
#.draw(x, y, z???, angle) to draw image
#Draw aligns to top left
#ALWAYS put draw in the entity class. Background goes in window
class GameWindow < Gosu::Window
  def initialize
    super 320, 224
    self.caption = "Tutorial Game"
    @backgroundImage = Gosu::Image.new("C:/GameTest/textures/backgroundPlaceholder.png", :tileable => true)
    @startButton = Button.new(100, 50, 160, 100, "startButton", "startButton", 8)
    @infoButton = Button.new(100, 50, 160, 170, "infoButton", "infoButton", 12)
    @selectButton1 = Button.new(80, 120, 60, 112, "Weapon", "selectButton1", 2)
    @selectButton2 = Button.new(80, 120, 160, 112, "Weapon", "selectButton2", 2)
    @selectButton3 = Button.new(80, 120, 260, 112, "Weapon", "selectButton3", 2)
    @wo1 = 0
    @wo2 = 0
    @tomere = 0
    @wo3 = 0
    @font = Gosu::Font.new(12)
    @backdiff = 1
    @infoImage = Gosu::Image.new("C:/GameTest/textures/infoPlaceholder.png", :tileable => true)
    @gamePhase = 1
    @tempsButtonReturn = [] #current button phase output. if not all -1, will find which isn't -1 and change phase
    @backButtonInfo = Button.new(100, 50, 60, 180, "backButton", "backButtonID", 4)
    @dark = Gosu::Image.new("C:/GameTest/textures/blackScreen.png")
    @timer = 0
    @totalTimer = 0
    @lastPhaseDivFour = 0
    @lastPhaseDeath = 0
    @map1 = Gosu::Image.new("C:/GameTest/textures/mapBackgroundA1.png")
    @map2 = Gosu::Image.new("C:/GameTest/textures/mapBackgroundA2.png")
    @title = Gosu::Image.new("C:/GameTest/textures/titlecard_icon.png")
    @player = Player.new("Feng")
    @enemies = [Enemy.new("basic", @player.getX + Random.rand(-170..170), Random.rand(0...224), @backdiff)]
    @attacklist = []
    @equipment = []
    @pity = 0
  end
  #update draw
  def draw
    @timer = Time.now

    if @lastPhaseDivFour
      @lastPhaseDivFour = false
      sleep 1
    end

    if @lastPhaseDeath
      @lastPhaseDeath = false
      sleep 1
    end

    if @gamePhase == 1
      @tomere = 0
      @backgroundImage.draw(0,0,0)
      @startButton.draw
      @infoButton.draw
      @title.draw_rot(160, 40, 0)

    elsif @gamePhase == 2
      @tomere += 1
      @player.getMX(mouse_x)
      @player.getMY(mouse_y)
      if @player.showHealth > 0
        @player.tickPlayer
      else
        @gamePhase = 20
      end

      if @player.showXP >= 100
        @player.giveXP(-1*100)
        @gamePhase = 6
        
        if(Random.rand(1..3) == 1)
          @selectButton1.setID("Weapon")
          @wo1 = Equipment.new(Math.sqrt(Random.rand(1..16)), "W", 1, @backdiff, Random.rand(0..2))
        else
          @selectButton1.setID("Acc")
          @wo1 = Equipment.new(Math.sqrt(Random.rand(1..16)), "W", 3, @backdiff, Random.rand(0..2))
        end
        if(Random.rand(1..3) == 1)
          @selectButton2.setID("Weapon")
          @wo2 = Equipment.new(Math.sqrt(Random.rand(1..16)), "W", 1, @backdiff, Random.rand(0..2))
        else
          @selectButton2.setID("Acc")
          @wo2 = Equipment.new(Math.sqrt(Random.rand(1..16)), "W", 3, @backdiff, Random.rand(0..2))
        end
        if(Random.rand(1..3) == 1)
          @selectButton3.setID("Weapon")
          @wo3 = Equipment.new(Math.sqrt(Random.rand(1..16)), "W", 1, @backdiff, Random.rand(0..2))
        else
          @selectButton3.setID("Acc")
          @wo3 = Equipment.new(Math.sqrt(Random.rand(1..16)), "W", 3, @backdiff, Random.rand(0..2))
        end
        sleep 1
      end

      @player.draw
      @map1.draw(-1*(@player.getX()%640 -320),0,0)
      @map2.draw(-1*((@player.getX()+320)%640 -320),0,0)
      @attacklist = @player.throwAttackList
      @parrylist = @player.throwParryList

      zono = 480/Math.sqrt(@backdiff)
      if zono < 100
        zono = 100
      elsif zono > 240
        zono = 240
      end

      @pity += 1

      if(Random.rand(0..zono) == 0 && @enemies.length < 20) || @pity >= 360
        if(Random.rand(0..3) != 3)
          @enemies.push(Enemy.new("basic", @player.getX + Random.rand(-170..170), Random.rand(0...224), @backdiff))
        else
          @enemies.push(Rat.new("rat", @player.getX + Random.rand(-170..170), Random.rand(0...224), @backdiff))
        end
        @pity = 0
      end

      if(@tomere % 1000 == 0)
        @backdiff += 1
      end

      @player.bumpEnemies(@enemies)

      for a in @attacklist
        a.draw
      end
      dp = false

      for a in @parrylist
        a.draw
        if a.didparry
          dp = true
        end
      end

      dakka = false
      healer = false

      for i in @player.getAccessoryList
        if i.getMajorID == "Shock Absorbers" && dp
          @player.setDash(0)
        elsif i.getMajorID == "Reap"
          dakka = true
        elsif i.getMajorID == "Barrier" && dp
          healer = true
        end
      end
      if healer && dp
        @player.heal(@player.getMaxHP * 0.05)
      end

      enemtemp = 0
      for enem in @enemies do
        enemtemp += 1
        enem.tickEnemy(@player.getX, @player.getY)

        if(enem.hitPlayer(@player.getX, @player.getY))
          @player.damagePla(enem.getDamage)
        end

        if (distance(enem.getX, @player.getX) < 170)
          enem.draw(@player.getX, @player.getY)
        end
        if(enem.getHP <= 0)
          @enemies.delete_at(enemtemp - 1)
          @player.giveXP(10)
          if dakka
            @player.setDash(0)
          end
        end
      end

      temphp = @player.showHealth.to_f/@player.getMaxHP.to_f
      draw_rect(0,0,42,14,Gosu::Color.argb(0xff_000000), 3)
      draw_rect(1,1,40,12,Gosu::Color.argb(0xff_ffffff), 3)
      draw_rect(1,1,(temphp * 40).round(0),12,Gosu::Color.argb(0xff_ff0000), 3)
      
      draw_rect(278,0,42,14,Gosu::Color.argb(0xff_000000), 3)
      draw_rect(279,1,40,12,Gosu::Color.argb(0xff_ffffff), 3)
      draw_rect(279,1,((@player.showXP.to_f/100) * 40).round(0),12,Gosu::Color.argb(0xff_00ff00), 3)
#
    elsif @gamePhase == 3
      @tomere = 0
      @infoImage.draw(0,0,0)
      @backButtonInfo.draw

    elsif (@gamePhase % 4 == 0)
      @tomere = 0
      @dark.draw(0,0,0)
      @lastPhaseDivFour = true
      @gamePhase = @gamePhase/4

    elsif (@gamePhase == 5)
      @tomere = 0
      @dark.draw(0,0,0)
      @enemies = []
      @attacklist = []
      @player.die
      @lastPhaseDeath = true
      if(@player.getlife > 0)
        @gamePhase = 8
      end
    
    #no6
    elsif (@gamePhase == 6)
      @tomere = 0
      @tempsButtonReturn = []
      @selectButton1.draw
      @selectButton2.draw
      @selectButton3.draw
      s = 0
      c = 0
      t = 0

      for i in @wo1.getStats
        if(i != 0)
          if(c == 0)
            t = "Heal: " + i.round(1).to_s
          elsif c == 1
            t = "HP: " + i.round(1).to_s
          elsif c == 2
            t = "Spd: " + i.round(1).to_s
          elsif c == 3
            t = "Dmg: " + i.round(1).to_s
          elsif c == 4
            t = "Dmg%: " + i.round(1).to_s
          end
          @font.draw_text(t, 30, 80 + 22*s, 1)
          s+= 1
        end
        c += 1
      end#

      @font.draw_text("DPS 1: " + @player.getWeapon1.getDPS.round(0).to_s, 10, 10, 1)
      @font.draw_text("DPS 2: " + @player.getWeapon2.getDPS.round(0).to_s, 230, 10, 1)
      @font.draw_text("Difficulty: " + @backdiff.to_s, 120, 10, 1)

      if(@wo1.getMajorID != "")
        @font.draw_text(@wo1.getIDDESC, 30, 80+22*(s+0), 1)
      end

      if(@wo1.getType == 1)
        @font.draw_text("DPS: " + @wo1.getDPS.round(0).to_s, 30, 80, 1)
        @font.draw_text("Slot: " + @wo1.getslot.to_s, 30, 102, 1)
        if(@wo1.getWeaponType == 0)
          @font.draw_text("Blade", 30, 124, 1)
        elsif(@wo1.getWeaponType == 1)
          @font.draw_text("Shield", 30, 124, 1)
        elsif(@wo1.getWeaponType == 2)
          @font.draw_text("Gun", 30, 124, 1)
        end
      end
      if(@wo2.getType == 1)
        @font.draw_text("DPS: " + @wo2.getDPS.round(0).to_s, 130, 80, 1)
        @font.draw_text("Slot: " + @wo2.getslot.to_s, 130, 102, 1)
        if(@wo2.getWeaponType == 0)
          @font.draw_text("Blade", 130, 124, 1)
        elsif(@wo2.getWeaponType == 1)
          @font.draw_text("Shield", 130, 124, 1)
        elsif(@wo2.getWeaponType == 2)
          @font.draw_text("Gun", 130, 124, 1)
        end
      end
      if(@wo3.getType == 1)
        @font.draw_text("DPS: " + @wo3.getDPS.round(0).to_s, 230, 80, 1)
        @font.draw_text("Slot: " + @wo3.getslot.to_s, 230, 102, 1)
        if(@wo3.getWeaponType == 0)
          @font.draw_text("Blade", 230, 124, 1)
        elsif(@wo3.getWeaponType == 1)
          @font.draw_text("Shield", 230, 124, 1)
        elsif(@wo3.getWeaponType == 2)
          @font.draw_text("Gun", 230, 124, 1)
        end
      end

      s = 0
      c = 0
      t = 0

      for i in @wo2.getStats
        if(i != 0)
          if(c == 0)
            t = "Heal: " + i.round(1).to_s
          elsif c == 1
            t = "HP: " + i.round(1).to_s
          elsif c == 2
            t = "Spd: " + i.round(1).to_s
          elsif c == 3
            t = "Dmg: " + i.round(1).to_s
          elsif c == 4
            t = "Dmg%: " + i.round(1).to_s
          end
          @font.draw_text(t, 130, 80 + 22*s, 1)
          s+= 1
        end
        c += 1
      end#

      if(@wo2.getMajorID != "")
        @font.draw_text(@wo2.getIDDESC, 130, 80+22*(s+0), 1)
      end

      s = 0
      c = 0
      t = 0

      for i in @wo3.getStats
        if(i != 0)
          if(c == 0)
            t = "Heal: " + i.round(1).to_s
          elsif c == 1
            t = "HP: " + i.round(1).to_s
          elsif c == 2
            t = "Spd: " + i.round(1).to_s
          elsif c == 3
            t = "Dmg: " + i.round(1).to_s
          elsif c == 4
            t = "Dmg%: " + i.round(1).to_s
          end
          @font.draw_text(t, 230, 80 + 22*s, 1)
          s+= 1
        end
        c += 1
      end

      if(@wo3.getMajorID != "")
        @font.draw_text(@wo3.getIDDESC, 230, 80+22*(s+0), 1)
      end

      @tempsButtonReturn << @selectButton1.tickButton(mouse_x, mouse_y)
      @tempsButtonReturn << @selectButton2.tickButton(mouse_x, mouse_y)
      @tempsButtonReturn << @selectButton3.tickButton(mouse_x, mouse_y)

      if @tempsButtonReturn[0] != -1
        @gamePhase = @tempsButtonReturn[0]
        if(@wo1.getType == 1)
          @player.setWep(@wo1,@wo1.getslot)
        else
          @player.giveAcc(@wo1)
        end
      elsif @tempsButtonReturn[1] != -1
        @gamePhase = @tempsButtonReturn[1]
        if(@wo2.getType == 1)
          @player.setWep(@wo2,@wo2.getslot)
        else
          @player.giveAcc(@wo2)
        end
      elsif @tempsButtonReturn[2] != -1
        puts "bun"
        @gamePhase = @tempsButtonReturn[2]
        if(@wo3.getType == 1)
          @player.setWep(@wo3,@wo3.getslot)
        else
          @player.giveAcc(@wo3)
        end
      end
    end

    @totalTimer = 0.01666 - (Time.now - @timer)
    if(@totalTimer > 0)
      sleep @totalTimer
    end
  end

  def needs_cursor?
    true
  end

  #update info button
  def update
    @tempsButtonReturn = []
    if @gamePhase == 1
      temp = 0
      
      @tempsButtonReturn << @startButton.tickButton(mouse_x, mouse_y)
      @tempsButtonReturn << @infoButton.tickButton(mouse_x, mouse_y)
      if @tempsButtonReturn[0] != -1
        @gamePhase = @tempsButtonReturn[0]
      elsif @tempsButtonReturn[1] != -1
        @gamePhase = @tempsButtonReturn[1]
      end
    elsif @gamePhase == 3
      temp = 0
      @tempsButtonReturn << @backButtonInfo.tickButton(mouse_x, mouse_y)
      if @tempsButtonReturn[0] != -1
        @gamePhase = @tempsButtonReturn[0]
      end
    end
  end
end
#s
#Button class
class Button
  def initialize(xsize, ysize, xpos, ypos, imageID, name, tozone)
    @imageID = imageID
    @xsize = xsize
    @ysize = ysize
    @xpos = xpos
    @ypos = ypos
    @ogID = imageID
    @tozone = tozone
    @image = Gosu::Image.new("C:/GameTest/textures/startButton.png")
    @name = name
  end

  def draw
    @image.draw_rot(@xpos, @ypos, 0, 0)
  end
  #Return statements
  def spitX
    return(@xpos)
  end

  def spitY
    return(@ypos)
  end

  def spitimage
    return(@image)
  end
  #What happens when you press the button
  def setID(name)
    @imageID = name
    @ogID = name
  end

  def tickButton(mx, my)
    @image = Gosu::Image.new("C:/GameTest/textures/" + @imageID.to_s + ".png") #Creating image with highlight
    if distance(@xpos.to_i, mx) < @xsize.to_i/2 && distance(@ypos.to_i, my) < @ysize.to_i/2 #Gets distance
      @imageID = @ogID + "Hlgt"
      if Gosu.button_down? Gosu::MsLeft
        @imageID = @ogID
        return @tozone
      end
    else
      @imageID = @ogID #resets to default
    end
    return -1
  end
end

GameWindow.new.show