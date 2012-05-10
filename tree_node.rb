class TreeNode
  attr_accessor :parent, :children, :value

  def initialize(value=nil)
    @value = value
    @children = []
  end

  def add_child(tree_node)
    @children << tree_node
    tree_node.parent = self
    tree_node
  end

  def root?
    parent.nil?
  end

  def root
    root? ? self : parent.root
  end

  def all
    descendants = children + children.map(&:all)
    descendants.flatten
  end

  def each
    all.each { |child| yield child }
  end
end
