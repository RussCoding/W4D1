require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board
  attr_accessor :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    new_arr = []
      i == 0
      j == 0
      while i < board.length
        j = 0 
        while j < board.length
          if !board[i][j].empty?
            dupe = board.dup
            dupe[i, j] = self.next_mover_mark
            self.prev_move_pos = [i, j]
            if self.next_mover_mark == :x 
              self.next_mover_mark = :o
            else
              self.next_mover_mark = :x
            end 
            new_arr << TicTacToeNode.new(dupe, next_mover_mark, prev_move_pos)
          end 
          j += 1
        end 
        i += 1
      end 
    new_arr
  end
end
