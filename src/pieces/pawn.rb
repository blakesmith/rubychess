require 'piece'

class Pawn < Piece

  def valid_moves
    #En passant handled by the game class each move? Not sure yet.
    moves = []
    if @color == 'white'
      move_two_squares = @square.top.top
      move_one_square = @square.top #Normal 1 piece move
      capture_diagonal = [@square.top_right, @square.top_left]
    end
    if @color == 'black' 
      move_two_squares = @square.bottom.bottom
      move_one_square = @square.bottom #Normal 1 piece move
      capture_diagonal = [@square.bot_right, @square.bot_left]
    end
    if @move_count == 0 #First move of the game.
      if move_two_squares.empty? and move_one_square.empty? 
        moves.push move_two_squares
      end
    end
    if move_one_square.empty?
      moves.push move_one_square
    end
    capture_diagonal.each do |square| #Diagonal capture
      if not square.empty?
        if square.piece.color != @color
          moves.push square
        end
      end
    end
    moves
  end
  

end
