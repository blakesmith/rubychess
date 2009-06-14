$LOAD_PATH << '../lib'
$LOAD_PATH << '../lib/pieces'

require 'test/unit'
require 'board'

class TestPawn < Test::Unit::TestCase

  def setup
    @board = Board.new
  end

  #Tests whether white and black can both move 1 squares in the opening position of the game.
  def test_pawn_initial_single_move
    assert_nothing_raised(RuntimeError) do 
      @board.do_move(@board.find_square('d2'), @board.find_square('d3'))
      @board.do_move(@board.find_square('d7'), @board.find_square('d6'))
    end
  end

  #Tests whether white and black can both move 2 squares in the opening position of the game.
  def test_pawn_initial_double_move
    assert_nothing_raised(RuntimeError) do 
      @board.do_move(@board.find_square('d2'), @board.find_square('d4'))
      @board.do_move(@board.find_square('d7'), @board.find_square('d5'))
    end
    assert_raise(RuntimeError) { @board.do_move(@board.find_square('d4'), @board.find_square('c5')) }
  end

  def test_pawn_capture
    assert_nothing_raised(RuntimeError) do 
      @board.do_move(@board.find_square('d2'), @board.find_square('d4'))
      @board.do_move(@board.find_square('e7'), @board.find_square('e5'))
      @board.do_move(@board.find_square('d4'), @board.find_square('e5'))
    end
    assert_equal(@board.find_square('e5').piece.move_count, 2) #Internal move count is correct
    assert_equal(@board.captured_pieces[:white].length, 1) #Make sure the piece was removed from the board.
  end

  def test_white_attack
    piece = @board.spawn(Pawn, 'white', 'd6')
    assert_not_nil(piece)
    assert_equal(piece.valid_moves, [@board.find_square('e7'), @board.find_square('c7')])
    assert_nothing_raised(RuntimeError) do 
      @board.do_move(@board.find_square('d6'), @board.find_square('e7'))
      @board.do_move(@board.find_square('e7'), @board.find_square('d8'))
    end
    assert_equal(@board.captured_pieces[:white].length, 2)
  end

  def test_black_attack
    piece = @board.spawn(Pawn, 'black', 'd3')
    assert_not_nil(piece)
    assert_equal(piece.valid_moves, [@board.find_square('e2'), @board.find_square('c2')])
    assert_nothing_raised(RuntimeError) do 
      @board.do_move(@board.find_square('d3'), @board.find_square('e2'))
      @board.do_move(@board.find_square('e2'), @board.find_square('d1'))
    end
    assert_equal(@board.captured_pieces[:black].length, 2)
  end

  def test_white_attack_en_passant
   attacker = @board.spawn(Pawn, 'white', 'd5', 1)
   defender = @board.find_square('c7').piece 
   assert_nothing_raised(RuntimeError) do
     @board.do_move(defender.square, @board.find_square('c5'))
     @board.do_move(attacker.square, @board.find_square('c6'))
   end
  end

  def test_black_attack_en_passant
   attacker = @board.spawn(Pawn, 'black', 'd4', 1)
   defender = @board.find_square('e2').piece
   assert_nothing_raised(RuntimeError) do
     @board.do_move(defender.square, @board.find_square('e4'))
     @board.do_move(attacker.square, @board.find_square('e3'))
   end
  end

  def test_en_passant_false_positive
    white = @board.spawn(Pawn, 'white', 'd5')
    black = @board.spawn(Pawn, 'black', 'c5')
    assert_raise(RuntimeError) { @board.do_move(white.square, @board.find_square('d5')) }
  end

end
