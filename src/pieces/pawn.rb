require 'piece'

class Pawn < Piece

  def valid_moves
    #En passant handled by the game class each move? Not sure yet.
    moves = []
    if @move_count == 0 #First move of the game.
      move_two_squares = @square.top.top
      if move_two_squares.empty? and @square.top.empty? 
        moves.push move_two_squares
      end
    end
    move_one_square = @square.top #Normal 1 piece move
    if move_one_square.empty?
      moves.push move_one_square
    end
    for square in [@square.top_right, @square.top_left] #Diagonal capture
      if not square.empty?
        if square.piece.color != @color
          moves.push square
        end
      end
    end
    moves
  end
  

end
