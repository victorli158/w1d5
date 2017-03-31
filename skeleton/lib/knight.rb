require_relative '00_tree_node'


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

  attr_reader :start
  attr_accessor :visited_positions

  def initialize(start_square = [0,0])
    @start = start_square
    @board = self.class.create_board
    @tree = self.build_move_tree
    @visited_positions = [@start]
  end

  def self.create_board
    Array.new(8) {Array.new(8)}
  end

  def build_move_tree
    seed = create_node(start)
    queue = [seed]
    until visited_positions.length == 64
      seed.children.each do |child|
        queue << create_node(child)




  end

  def create_node(pos)
    seed = PolyTreeNode.new
    new_move_positions(start).each do |move|
      visited_positions << move #is this right?
      seed.children.add_child(move)
    end
    seed
  end

  def find_path
  end

  def self.valid_moves(pos)
    pos_moves = MOVERS.map { |move| [pos[0] + move[0], pos[1] + move[1]] }
    pos_moves.reject! { |move| move[0] > 7 || move[0] < 0 || move[1] > 7 || move[1] < 0 }
    pos_moves
  end

  def new_move_positions(pos)
    moves = self.class.valid_moves(pos)
    moves.reject! { |move| visited_positions.include?(move)}
    moves
  end

end
