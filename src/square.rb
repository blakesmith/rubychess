class Square
  attr_accessor :left, :top, :right, :bottom, :top_left, :top_right, :bot_right, :bot_left
  attr_accessor :coordinates, :piece, :color

  def initialize(color=nil, coordinates=nil)
    self.color = color
    self.coordinates = coordinates
  end

  def is_empty
    if @piece.nil?
      true
    else
      false
    end
  end

end
