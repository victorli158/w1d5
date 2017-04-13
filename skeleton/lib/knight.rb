require_relative '00_tree_node'
require 'byebug'

class KnightPathFinder

  MOVERS = [
    [-2, -1],
    [-2, 1],
    [-1, -2],
    [-1, 2],
    [1, -2],
    [1, 2],
    [2, -1],
    [2, 1]
  ]

  attr_reader :start, :tree
  attr_accessor :visited_positions

  def initialize(start_square = [0,0])
    @start = start_square
    @board = self.class.create_board
    @visited_positions = [@start]
    @tree = self.build_move_tree
  end

  def self.create_board
    Array.new(8) {Array.new(8)}
  end

  def build_move_tree
    root = create_node(start)
    queue = [root]
    until queue.empty?
      first = queue.shift
      first.children.each do |child|
        new_node = create_node(child.value)
        queue.push(new_node)
        new_node.parent = first
        debugger
      end
    end
    root
  end

  def create_node(pos)
    seed = PolyTreeNode.new(pos)
    new_move_positions(pos).each do |move|
      visited_positions << move #is this right?
      seed.add_child(PolyTreeNode.new(move))
    end
    seed
  end

  def find_path
  end

  def self.valid_moves(pos)
    pos_moves = MOVERS.map { |move| [pos[0] + move[0], pos[1] + move[1]] }
    pos_moves.reject { |move| move[0] > 7 || move[0] < 0 || move[1] > 7 || move[1] < 0 }
  end

  def new_move_positions(pos)
    moves = self.class.valid_moves(pos)
    moves.reject { |move| visited_positions.include?(move)}
  end

end

if __FILE__ == $PROGRAM_NAME
  k = KnightPathFinder.new([0,0])
  puts k.tree
end
