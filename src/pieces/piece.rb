class Piece
  attr_accessor :piece
  attr_accessor :value
  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def valid_moves
    #overide to add moves to the piece
  end
end
