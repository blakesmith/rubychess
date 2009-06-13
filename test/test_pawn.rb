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

end
