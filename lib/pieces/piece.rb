class Piece
  attr_accessor :piece, :value, :color, :square, :move_count

  def initialize(color)
    @color = color
    @move_count = 0
  end

  def valid_moves
    moves = []
    setup_color
    self.methods.grep(/^check_/) do |test|
      if not test.nil?
        squares = eval test
        squares.each { |square| moves.push square if not square.nil? } if not squares.nil?
      end
    end
    moves
  end

end
