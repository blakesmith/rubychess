require 'square'

require File.join(File.dirname(__FILE__), 'pieces', 'pawn')
require File.join(File.dirname(__FILE__), 'pieces', 'knight')
require File.join(File.dirname(__FILE__), 'pieces', 'bishop')
require File.join(File.dirname(__FILE__), 'pieces', 'rook')
require File.join(File.dirname(__FILE__), 'pieces', 'queen')
require File.join(File.dirname(__FILE__), 'pieces', 'king')

class Board
  attr_accessor :squares, :captured_pieces

  def initialize
    @squares = []
    @captured_pieces = { :black => [], :white => [] }
    create_squares
    make_connections
    create_pieces
  end

  #Returns the found square for the given grid coordinates: For example, find_square "h3" will return the instance of the square object at location "h3".
  def find_square(grid)
    @squares.detect do |square|
       square.get_grid == grid.downcase
    end
  end

  def spawn(piece, color, square, move_count=0)
    new_piece = piece.new color
    target_square = self.find_square(square) 
    new_piece.square = target_square
    new_piece.move_count = move_count
    target_square.piece = new_piece
    new_piece
  end

  #Execute an actual valid_move on the board. Both inputs must be square objects.
  def do_move(from, to)
    raise RuntimeError.new "There is no piece at that location" if from.empty?
    raise RuntimeError.new "That is not a legal move." if not from.piece.valid_moves.include?(to)
    #Lets see if the destination square has an existing piece, if so, it's a capture. 
    if not to.empty?

      #Get the color of the piece being captured, so we can add it to the opposing colors 'captured_pieces'
      capture = true
      if to.piece.color == "white"
        @captured_pieces[:black].push(to.piece)
      else
        @captured_pieces[:white].push(to.piece)
      end
    end
    if capture
      to.piece.square = nil  #Captured piece goes to @captured_pieces, so no square reference.
    end

    #Do the actual moving.
    to.piece = from.piece
    to.piece.move_count += 1
    to.piece.square = to #Update the reference to the square the piece is on.
    from.piece = nil
    true
  end

  def create_squares
    1.upto(8).each do |column|
      1.upto(8).each do |row|
        if (row.modulo(2).zero? and column.modulo(2).zero?) or (not row.modulo(2).zero? and not column.modulo(2).zero?)
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
    8.upto(15).each do |square|
      @squares[square].piece = Pawn.new 'white'
    end

    #black pawns
    48.upto(55).each do |square|
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
    0.upto(15).each do |square|
      @squares[square].piece.square = @squares[square]
    end
    
    #Add black square pointers to pieces
    48.upto(63).each do |square|
      @squares[square].piece.square = @squares[square]
    end
  end
end
