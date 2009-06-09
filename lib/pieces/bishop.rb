require 'piece'

class Bishop < Piece

  def valid_moves
    [
     {:direction => 'tr', :count => 8},
     {:direction => 'tl', :count => 8},
     {:direction => 'bl', :count => 8},
     {:direction => 'br', :count => 8},
    ]
  end
end
