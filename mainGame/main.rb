#Import Gosu. Press f5 to update code after edits
require 'gosu'
require_relative 'usefulFunctions'

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
    @startButton = Button.new(100, 50, 160, 100, "startButton", "startButton", 2)
    @infoButton = Button.new(100, 50, 160, 170, "infoButton", "infoButton", 3)
    @infoImage = Gosu::Image.new("C:/GameTest/textures/infoPlaceholder.png", :tileable => true)
    @gamePhase = 1
  end
  #update draw
  def draw
    if @gamePhase == 1
      @backgroundImage.draw(0,0,0)
      @startButton.draw
      @infoButton.draw
    elsif @gamePhase == 3
      @infoImage.draw(0,0,0)
    end
  end

  def needs_cursor?
    true
  end

  #update info button
  def update
    if @gamePhase == 1
      temp = 0
      @gamePhase = @startButton.tickButton(mouse_x, mouse_y)
      @gamePhase = @infoButton.tickButton(mouse_x, mouse_y)
    end
    puts(@gamePhase)
  end
end

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
        return tozone
      end
    else
      @imageID = @ogID #resets to default
    end
    return -1
  end
end

GameWindow.new.show