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

end
