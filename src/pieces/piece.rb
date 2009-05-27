class Piece
  attr_accessor :piece, :value, :color, :square

  def initialize(color)
    @color = color
  end

  def valid_moves
    #overide to add moves to the piece
  end
end
