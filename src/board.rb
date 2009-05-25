require 'square'

class Board
  attr_accessor :squares

  def initialize
    @squares = []
    create_squares
  end

  def create_squares
    for row in 1..8
      for column in 1..8
        if row.even? and column.even? or row.odd? and column.odd?
          color = 'black'
        else
          color = 'white'
        end
        @squares.push Square.new color, [row, column]
      end
    end
  end

end
