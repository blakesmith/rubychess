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

end
