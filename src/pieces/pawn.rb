require 'piece'

class Pawn < Piece

  def valid_moves
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
    moves
  end
  

end
