require 'square'

class Board
  attr_accessor :squares

  def initialize
    @squares = []
    create_squares
    make_connections
  end

  def create_squares
    for column in 1..8
      for row in 1..8
        if (row.even? and column.even?) or (row.odd? and column.odd?)
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
      #Find the array index based on the coordinates:
      position = (square.coordinates[0]  - 1) + ((square.coordinates[1] * 8) - 8)

      #Link all directions to instances of their neigbors.
      square.top = @squares[position + 8]
      square.top_right = @squares[position + 9]
      square.right = @squares[position + 1]
      square.bot_right = @squares[position - 7]
      square.bottom = @squares[position - 8]
      square.bot_left = @squares[position - 9]
      square.left = @squares[position - 1]
      square.top_left = @squares[position + 7]

      if square.coordinates[0] == 1
        square.left = square.top_left = square.bot_left = nil
      end
      if square.coordinates[0] == 8
        square.right = square.top_right = square.bot_right = nil
      end
      if square.coordinates[1] == 1
        square.bottom = square.bot_left = square.bot_right = nil
      end
      if square.coordinates[1] == 8
        square.top = square.top_left = square.top_right = nil
      end
    end
  end

end
