class Square
  attr_accessor :left, :top, :right, :bottom, :top_left, :top_right, :bot_right, :bot_left
  attr_accessor :coordinates, :piece, :color

  def initialize(color=nil, coordinates=nil)
    @color = color
    @coordinates = coordinates
  end

  def empty?
    if @piece.nil?
      true
    else
      false
    end
  end

  def get_grid
    cords = { 1 => 'a', 2 => 'b', 3 => 'c', 4 => 'd', 5 => 'e', 6 => 'f', 7 => 'g', 8 => 'h' }
    if not @coordinates.nil?
      cords[@coordinates[0]] + @coordinates[1].to_s
    end
  end

  def inspect
    if not @color.nil? and not @coordinates.nil?
      self.get_grid + ': ' + @color
    end
  end

end
