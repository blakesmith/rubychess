$LOAD_PATH << '../lib'
$LOAD_PATH << '../lib/pieces'

require 'test/unit'
require 'board'

class TestBoard < Test::Unit::TestCase

  def setup
    @board = Board.new
  end

  def test_board_init
    assert_not_nil(@board)
  end

  def test_square_count
    assert_equal(64, @board.squares.length)
  end

  def test_find_square
    assert_equal(@board.find_square("d1"), @board.squares[3])
    assert_equal(@board.find_square("d2"), @board.squares[11])
    assert_nil(@board.find_square("foo"))
  end

  def test_spawn
    @board.spawn(Pawn, "white", 'd4')
    assert_equal(@board.find_square('d4').piece.move_count, 1)
    assert_equal(@board.find_square('d4'), @board.find_square('d4').piece.square)
  end

end
