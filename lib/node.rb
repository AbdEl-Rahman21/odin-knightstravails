# frozen_string_literal: true

class Node
  attr_reader :parent, :coordinates

  def initialize(coordinates, parent = nil)
    @parent = parent
    @coordinates = coordinates
  end

  def trace(node = self, array = [])
    return array if node.nil?

    array.unshift(node)

    trace(node.parent, array)
  end
end
