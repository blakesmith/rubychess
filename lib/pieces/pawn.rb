require 'piece'

class Pawn < Piece

  def setup_color
    if @color == 'white'
      @@move_one_square = @square.top #Normal 1 piece move
      if not @@move_one_square.nil?
        @@move_two_squares = @square.top.top
      else
        @@move_two_squares = nil
      end
      @@capture_diagonal = [@square.top_right, @square.top_left]
    end
    if @color == 'black' 
      @@move_one_square = @square.bottom #Normal 1 piece move
      if not @@move_one_square.nil?
        @@move_two_squares = @square.bottom.bottom
      else
        @@move_two_squares = nil
      end
      @@capture_diagonal = [@square.bot_right, @square.bot_left]
    end
  end

  def check_two_squares
    if @move_count == 0 #First move of the game.
      if not @@move_two_squares.nil? and not @@move_one_square.nil? #Make sure the piece doesn't run off the board.
        if @@move_two_squares.empty? and @@move_one_square.empty?
          [@@move_two_squares]
        end
      end
    end
  end

  def check_one_square
    if not @@move_one_square.nil? #Piece running off the board.
      if @@move_one_square.empty?
        [@@move_one_square]
      end
    end
  end

  def diagonal_capture
    moves = []
    @@capture_diagonal.find_all do |square| #Diagonal capture
      if not square.nil?
        if not square.empty?
          if square.piece.color != @color
            moves.push square
          end
        end
      end
      if moves.empty?
        false
      else
        moves
      end
    end
  end

  def valid_moves
    #En passant handled by the game class each move? Not sure yet.
    moves = []
    setup_color
    [check_two_squares, check_one_square, diagonal_capture].each do |test|
      if not test.nil?
        test.each {|move| moves.push move if not move.nil?}
      end
    end
    moves
  end
  
end
