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

  def make_connections
    @squares.each do |square|
      if square.coordinates[0] == 1
        square.bottom = square.bot_left = square.bot_right = nil
      end
      if square.coordinates[0] == 8
        square.top = square.top_left = square.top_right = nil
      end
      if square.coordinates[1] == 1
        square.left = square.top_left = square.bot_left = nil
      end
      if square.coordinates[1] == 8
        square.right = square.top_right = square.bot_right = nil
      end

end
