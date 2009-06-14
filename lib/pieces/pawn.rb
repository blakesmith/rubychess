require 'piece'

class Pawn < Piece

  def update
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
    @@en_passant = [@square.left, @square.right]
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

  def check_diagonal_capture
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

  #En Passant pawn move. This will add valid en passant moves if the position for the pawn is correct.
  #The Game engine that keeps track of move history has the final decision about whether the move is
  #legal
  def check_en_passant
    moves = []
    @@en_passant.each do |square|
      if square.piece.class == Pawn and square.color != @color
        if @color == 'white' and @square.coordinates[1] == 5
          if square == @square.left
            moves.push @square.top_left
          end
          if square == @square.right
            moves.push @square.top_right
          end
        elsif @color == 'black' and @square.coordinates[1] == 4
          if square == @square.left
            moves.push @square.bot_left
          end
          if square == @square.right
            moves.push @square.bot_right
          end
        end
      end
    end
    moves
  end

end
