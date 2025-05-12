#Import Gosu. Press f5 to update code after edits
require 'gosu'
require_relative 'usefulFunctions'
require_relative "player"

#gamephase info
#1 = title screen. 2 = game. 3 = info. Every 4th will be black transfer screen to /4. ex 4 -> 1, 8 -> 2

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
    @infoImage = Gosu::Image.new("C:/GameTest/textures/infoPlaceholder.png", :tileable => true)
    @gamePhase = 1
    @tempsButtonReturn = [] #current button phase output. if not all -1, will find which isn't -1 and change phase
    @backButtonInfo = Button.new(100, 50, 60, 180, "backButton", "backButtonID", 4)
    @dark = Gosu::Image.new("C:/GameTest/textures/blackScreen.png")
    @timer = 0
    @totalTimer = 0
    @lastPhaseDivFour = 0
    @map1 = Gosu::Image.new("C:/GameTest/textures/mapBackgroundA1.png")
    @map2 = Gosu::Image.new("C:/GameTest/textures/mapBackgroundA2.png")
    @player = Player.new("Feng")
  end
  #update draw
  def draw
    @timer = Time.now

    if @lastPhaseDivFour
      @lastPhaseDivFour = false
      sleep 1
    end

    if @gamePhase == 1
      @backgroundImage.draw(0,0,0)
      @startButton.draw
      @infoButton.draw

    elsif @gamePhase == 2
      if @player.getlife > 0
        @player.tickPlayer
      end
      @player.draw
      @map1.draw(-1*(@player.getX()%360 + 160),0,0)

    elsif @gamePhase == 3
      @infoImage.draw(0,0,0)
      @backButtonInfo.draw

    elsif (@gamePhase % 4 == 0)
      @dark.draw(0,0,0)
      @lastPhaseDivFour = true
      @gamePhase = @gamePhase/4
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
    #puts(@gamePhase)
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
  def response()
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