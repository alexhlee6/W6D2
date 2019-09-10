require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)

    node.children.each do |child_node| 
      if child_node.winning_node?(mark) 
        return child_node.prev_move_pos
      end 
    end 

    node.children.each do |child_node| 
      if !child_node.losing_node?(mark) 
        return child_node.prev_move_pos
      end 
    end 

    raise "Error: No winning or losing nodes"
  end

end



if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
