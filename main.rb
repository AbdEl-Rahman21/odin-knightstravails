# frozen_string_literal: true

require_relative './lib/node'

def check_input(start_point, end_point = [0, 0])
  return false unless start_point.length == 2 && end_point.length == 2

  start_point.each { |e| return false if e > 7 || e.negative? }
  end_point.each { |e| return false if e > 7 || e.negative? }

  true
end

def traverse(current, end_point, array = [])
  return current if current.coordinates == end_point

  lam = lambda { |array, temp, current|
    array.push(Node.new(temp, current)) if current.parent.nil? || temp != current.parent.coordinates
  }

  temp = [current.coordinates[0] + 2, current.coordinates[1] - 1]

  lam.call(array, temp, current) if check_input(temp)

  temp = [current.coordinates[0] + 2, current.coordinates[1] + 1]

  lam.call(array, temp, current) if check_input(temp)

  temp = [current.coordinates[0] - 2, current.coordinates[1] - 1]

  lam.call(array, temp, current) if check_input(temp)

  temp = [current.coordinates[0] - 2, current.coordinates[1] + 1]

  lam.call(array, temp, current) if check_input(temp)

  #---------------------------------

  temp = [current.coordinates[0] + 1, current.coordinates[1] - 2]

  lam.call(array, temp, current) if check_input(temp)

  temp = [current.coordinates[0] + 1, current.coordinates[1] + 2]

  lam.call(array, temp, current) if check_input(temp)

  temp = [current.coordinates[0] - 1, current.coordinates[1] - 2]

  lam.call(array, temp, current) if check_input(temp)

  temp = [current.coordinates[0] - 1, current.coordinates[1] + 2]

  lam.call(array, temp, current) if check_input(temp)

  array.each { |e| print "#{e.coordinates} \s" }
  p '/n'

  traverse(array.shift, end_point, array)
end

def knight_moves(start_point, end_point)
  return nil unless check_input(start_point, end_point)

  temp = traverse(Node.new(start_point), end_point)

  a = temp.trace(temp)

  puts "You made it in #{a.length - 1} moves!  Here's your path:"

  a.each { |e| p e.coordinates }
end

p knight_moves([3, 3], [4, 3])
