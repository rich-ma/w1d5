require_relative '00_tree_node.rb'
class KnightPathFinder
  def initialize(pos)
    @moves = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,-2],[-1,2]]
    @pos = pos
    @visit_pos = Hash.new(false)
    @move_tree = PolyTreeNode.new(pos)
    @grid = Array.new(8) { Array.new(8)}
  end

  def valid_moves(pos)
    result = []
    @moves.each do |step|
      new_pos = pos.dup
      new_pos[0] = pos[0] + step[0]
      new_pos[1] = pos[1] + step[1]
      result << new_pos if valid?(new_pos)
    end
    result
  end
  
  def valid?(pos)
    pos.all? {|axis| (0..7).to_a.include?(axis)}
    
  end

  def build_move_tree(pos)
    queue = [@move_tree]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == pos
      possible_moves = valid_moves(current_node.value)
      possible_moves.each do |move|
        if valid_child?(move, current_node)
          new_child = PolyTreeNode.new(move)
          new_child.parent = current_node
          queue << new_child
        end
      end
    end
  end

  def valid_child?(pos, node)
    return false if node.value == pos
    return true if node.parent.nil?
    valid_child?(pos, node.parent)
  end
  
  def find_path(pos)
    target_node = build_move_tree(pos)
    display_path(target_node)
  end
  
  def display_path(node)
    return [node.value] if node.parent.nil?
    display_path(node.parent) << node.value
  end

end
 # # 
 # a = PolyTreeNode.new([1,1])
 #  b = PolyTreeNode.new([1,2])
 #   c = PolyTreeNode.new([1,3])
 #   a.add_child(b)
 #   b.add_child(c)
 # 
 #  d = PolyTreeNode.new([1,1])
 #  valid_child?(d.value, c)
 # 