class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def parent=(value)
    @parent = value
    @parent.children << self unless value == nil
  end

  


end
