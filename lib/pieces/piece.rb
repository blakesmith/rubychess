class Piece
  attr_accessor :piece, :value, :color, :square, :move_count

  def initialize(color)
    @color = color
    @move_count = 0
  end

  def update
    #overide with things that need to be 'updated' on each 'valid_moves' check.
  end

  def valid_moves
    moves = []
    update
    self.methods.grep(/^check_/) do |test|
      if not test.nil?
        squares = eval test
        squares.each { |square| moves.push square if not square.nil? } if not squares.nil?
      end
    end
    moves
  end

end
