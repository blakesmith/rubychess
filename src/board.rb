$LOAD_PATH << './pieces'

require 'square'
require 'pawn'
require 'knight'
require 'bishop'
require 'rook'
require 'queen'
require 'king'

class Board
  attr_accessor :squares

  def initialize
    @squares = []
    create_squares
    make_connections
    create_pieces
  end

  def find_square(grid)
    found = nil
    @squares.each do |square|
      if square.get_grid == grid
        found = square
      end
    end
    found
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

  def create_pieces
    #white pawns
    for square in 8..15
      @squares[square].piece = Pawn.new 'white'
    end

    #black pawns
    for square in 48..55
      @squares[square].piece = Pawn.new 'black'
    end

    #white royalty
    @squares[0].piece = Rook.new 'white'
    @squares[1].piece = Knight.new 'white'
    @squares[2].piece = Bishop.new 'white'
    @squares[3].piece = Queen.new 'white'
    @squares[4].piece = King.new 'white'
    @squares[5].piece = Bishop.new 'white'
    @squares[6].piece = Knight.new 'white'
    @squares[7].piece = Rook.new 'white'

    #black royalty
    @squares[56].piece = Rook.new 'black'
    @squares[57].piece = Knight.new 'black'
    @squares[58].piece = Bishop.new 'black'
    @squares[59].piece = Queen.new 'black'
    @squares[60].piece = King.new 'black'
    @squares[61].piece = Bishop.new 'black'
    @squares[62].piece = Knight.new 'black'
    @squares[63].piece = Rook.new 'black'

    #Add white square pointers to pieces
    for square in 0..15
      @squares[square].piece.square = @squares[square]
    end
    
    #Add black square pointers to pieces
    for square in 48..63
      @squares[square].piece.square = @squares[square]
    end
  end
end
