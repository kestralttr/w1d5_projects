require_relative '00_tree_node.rb'

require 'byebug'

class KnightPathFinder
  attr_reader :move_tree
  DELTAS = [
    [-1, 2],
    [1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2],
    [-2, -1],
    [-2, 1],
  ]

  def self.valid_moves(pos)
    moves = []
    x , y = pos
    moves = DELTAS.map do |coord|
      [coord[0] + x, coord[-1] + y]
    end
  end

  def initialize(pos)
    @pos = pos
    @visited_positions = [pos]
    @move_tree = PolyTreeNode.new(@pos)
    build_move_tree(@move_tree)
  end

  def build_move_tree(child)
    # debugger
    new_moves = new_move_positions(child.value)
    return nil if new_moves.empty?

    new_moves.each do |move|
      temp_child = PolyTreeNode.new(move)
      @move_tree.add_child(temp_child)
    end

    @move_tree.children.each do |child|
      build_move_tree(child)
    end
  end

  # def build_new_branch(root)
  #   new_moves = new_move_positions(root.value)
  #
  #   new_moves.each do |move|
  #     temp_child = PolyTreeNode.new(move)
  #     root.add_child(temp_child)
  #   end
  #
  # end

  def new_move_positions(pos)
    positions = self.class.valid_moves(pos)

    new_positions = positions.select do |position1|
      position1[0] > 0 && position1[0] < 8 &&
      position1[1] > 0 && position1[1] < 8
    end

    new_positions.delete_if do |position|
      @visited_positions.include?(position)
    end

    @visited_positions += new_positions

    new_positions
  end

  def find_path(end_pos)
    # debugger
    end_node = @move_tree.bfs(end_pos)
    arr = []
    path = trace_path_back(end_node,arr)
  end

  def trace_path_back(node,arr)
    #debugger
    if node.parent == nil
      arr << [node.value]
    else
      #path = [node.value]
      arr << [node.value] + [trace_path_back(node.parent)]
    end

  end

end

n = KnightPathFinder.new([0,0])


p n.find_path([6,2])
