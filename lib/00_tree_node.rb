

class PolyTreeNode

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end

  def value
    @value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def parent=(value)
    @parent.children.delete_if {|i| i == self} unless @parent.nil?
    @parent = value
    @parent.children << self unless value == nil #|| @parent.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self unless child_node.parent == self
  end

  def remove_child(child_node)
    raise "Error" unless @children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return self if self.value == target

    @children.each do |child|
      instance = child.dfs(target)
      return instance if instance != nil #&& instance.value == target
    end

    nil
  end

  def bfs(target)
    q = [self]

    # note - reverse queue - maybe switch
    until q.empty?
      node = q.shift
      return node if node.value == target
      node.children.each {|child| q << child}
    end
  end

end
