require 'byebug'

class PolyTreeNode
attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    if node.nil?
      @parent = nil
    else
      @parent.remove_child(self) unless @parent.nil?
      @parent = node
      node.add_child(self)
    end
  end

  def add_child(node)
    @children << node unless @children.include?(node)
    node.parent = self if node.parent == nil #only do this if parent is nil
  end

  def remove_child(node)
    raise "node is not child" unless self.children.include?(node)
    @children.delete_if { |el| el == node }
    node.parent = nil
  end

  def dfs(target_value)
    # debugger
    if self.value == target_value
      return self
    else
      self.children.each do |child|
        search = child.dfs(target_value)
        return search unless search.nil?
      end
      nil
    end
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      first = queue.shift
      if first.value == target_value
        return first
      else
        queue += first.children
      end
    end
  end

end
