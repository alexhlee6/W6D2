require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # potential_node.losing_node?(:x)
  # recursive step: 
    # if current player is me and all of our children are losing nodes 
    # then we lose 
    # if opponent's turn and they have a child node that leads to our loss, then we are losing 

  def losing_node?(evaluator)
    return false if @board.over? && (@board.winner == evaluator || @board.winner.nil?)
    return true if @board.over? && @board.winner != evaluator 
    
    if next_mover_mark == evaluator
      self.children.all? { |node| node.losing_node?(evaluator) }
    else  
      self.children.any? { |node| node.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return true if @board.over? && @board.winner == evaluator 
    return false if @board.over? && @board.winner != evaluator

    if next_mover_mark == evaluator
      self.children.any? { |node| node.winning_node?(evaluator) }
    else  
      self.children.all? { |node| node.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    nodes_array = [] 
    @board.rows.each_with_index do |row, i| 
      row.each_with_index do |_, j| 
        if @board.empty?([i,j])
          child_board = @board.dup 
          child_board.rows[i][j] = next_mover_mark 
          if next_mover_mark == :x 
            nodes_array << TicTacToeNode.new(child_board, :o, [i,j])
          else  
            nodes_array << TicTacToeNode.new(child_board, :x, [i,j])
          end
        end 
      end 
    end 
    nodes_array
  end
end
