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
    @startButton = Button.new(100, 50, 160, 112, "startButton", "startButton")
  end

  def draw
    @backgroundImage.draw(0,0,0)
    @startButton.draw
  end

  def needs_cursor?
    true
  end

  def update
    @startButton.tickButton(mouse_x, mouse_y)
  end
end


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

  def spitX
    return(@xpos)
  end

  def spitY
    return(@ypos)
  end

  def spitimage
    return(@image)
  end

  def tickButton(mx, my)
    @image = Gosu::Image.new("C:/GameTest/textures/" + @imageID.to_s + ".png")
    if distance(@xpos.to_i, mx) < @xsize.to_i && distance(@ypos.to_i, my) < @ysize.to_i
      @imageID = @ogID + "Hlgt"
    else
      @imageID = @ogID
    end
  end
end

GameWindow.new.show