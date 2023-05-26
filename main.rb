# frozen_string_literal: true

require_relative './lib/node'

def check_input(start_point, end_point = [0, 0])
  return false unless start_point.length == 2 && end_point.length == 2

  start_point.each { |e| return false if e > 7 || e.negative? }
  end_point.each { |e| return false if e > 7 || e.negative? }

  true
end

def get_children(current, array, &block)
  i = 2
  j = 1

  2.times do
    temp = [current.coordinates[0] + i, current.coordinates[1] - j]

    block.call(array, temp, current) if check_input(temp)

    temp = [current.coordinates[0] + i, current.coordinates[1] + j]

    block.call(array, temp, current) if check_input(temp)

    temp = [current.coordinates[0] - i, current.coordinates[1] - j]

    block.call(array, temp, current) if check_input(temp)

    temp = [current.coordinates[0] - i, current.coordinates[1] + j]

    block.call(array, temp, current) if check_input(temp)

    i, j = j, i
  end
end

def traverse(current, end_point, array = [])
  return current if current.coordinates == end_point

  get_children(current, array) do |arr, temp, curr|
    arr.push(Node.new(temp, curr)) if curr.parent.nil? || temp != curr.parent.coordinates
  end

  traverse(array.shift, end_point, array)
end

def knight_moves(start_point, end_point)
  return nil unless check_input(start_point, end_point)

  temp = traverse(Node.new(start_point), end_point).trace

  puts "You made it in #{temp.length - 1} moves!  Here's your path:"

  temp.each { |e| puts e.coordinates.to_s }
end

knight_moves([3, 3], [4, 3])
