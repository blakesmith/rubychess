class Piece
  attr_accessor :piece, :value, :color, :square, :move_count

  def initialize(color)
    @color = color
    @move_count = 0
  end

  def valid_moves
    #overide to add moves to the piece
  end
end
