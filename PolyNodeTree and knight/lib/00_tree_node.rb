class PolyTreeNode
  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end

  def parent
    parent
  end

  def children
    children
  end

  def value
    value
  end

  def parent=(node = nil)
    parent.children.delete(self) if parent
    @parent = node
    if node
      parent.children << self unless parent.children.include?(self)
    end
  end

  def add_child(child)
    children << child unless children.include?(child)
    child.parent = self
  end

  def remove_child(child)
    raise "Node is currently a child" unless children.include?(child)
    children.delete(child)
    child.parent = nil
  end


  def dfs(target)
    result = nil
    return self if value == target
    return nil if children.empty?
    children.each do |child|
      result = child.dfs(target)
      return result if result
    end
    result
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current = queue.shift
      return current if current.value == target
      queue.concat(current.children)
    end
    nil
  end

  def inspect
    self
  end

  attr_reader :value, :parent, :children

  attr_writer :children
end
