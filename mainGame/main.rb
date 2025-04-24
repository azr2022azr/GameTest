#Import Gosu. Press f5 to fix code not running
require 'gosu'

#.draw(x, y, z???, angle) to draw image
#Draw aligns to top left
class gameWindow < Gosu::Window
  def initialize
    super 320, 224
    self.caption = "Tutorial Game"
  end
end

gameWindow.new.show