#Import Gosu. Press f5 to update code after edits
require 'gosu'
require_relative 'usefulFunctions'

#.draw(x, y, z???, angle) to draw image
#Draw aligns to top left
#ALWAYS put draw in the entity class. Background goes in window
class GameWindow < Gosu::Window
  def initialize
    super 320, 224
    self.caption = "Tutorial Game"
    @backgroundImage = Gosu::Image.new("C:/GameTest/textures/backgroundPlaceholder.png", :tileable => true)
    @startButton = StartButton.new(100, 50, 160, 112, "startButton", "startButton")
    @gamePhase = 0
  end

  def draw
    @backgroundImage.draw(0,0,0)
    @startButton.draw
  end

  def needs_cursor?
    true
  end

  def update
    if @gamePhase == 0
      @gamePhase = @startButton.tickButton(mouse_x, mouse_y)
    end
    puts(@gamePhase)
  end
end

#Button class
class Button
  def initialize(xsize, ysize, xpos, ypos, imageID, name)
    @imageID = imageID
    @xsize = xsize
    @ysize = ysize
    @xpos = xpos
    @ypos = ypos
    @ogID = imageID
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
        return response()
      end
    else
      @imageID = @ogID #resets to default
    end
    return 0
  end
end

class StartButton < Button
  def response()
    @imageID = @ogID
    return 1
  end
end

GameWindow.new.show