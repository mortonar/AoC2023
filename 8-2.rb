#!/usr/bin/env ruby

# WARNING! This won't work in the general case.
# The input is specially crafted to have 6 closed loops.

instructions = $stdin.readline.strip.chars.to_a
_blank = $stdin.readline

nodes = $stdin.readlines.each_with_object({}) do |line, nodes|
  node, left, right = line.match(/(\w{3}) = \((\w{3}), (\w{3})\)/)[1,3]
  nodes[node] = {'L' => left, 'R' => right}
end

a_nodes = nodes.keys.select { |k| k.end_with?('A') }
a_lengths = a_nodes.map do |node|
  steps = 0
  i = 0
  loop do
    steps += 1
    node = nodes[node][instructions[i]]
    break if node.end_with?('Z')
    i = (i + 1) % instructions.size
  end
  steps
end
puts a_lengths.reduce(1, :lcm)
