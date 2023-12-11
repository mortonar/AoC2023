#!/usr/bin/env ruby

instructions = $stdin.readline.strip.chars.to_a
_blank = $stdin.readline

nodes = $stdin.readlines.each_with_object({}) do |line, nodes|
  node, left, right = line.match(/([A-Z]{3}) = \(([A-Z]{3}), ([A-Z]{3})\)/)[1,3]
  nodes[node] = {'L' => left, 'R' => right}
end

steps = 0
i = 0
node ='AAA'
loop do
  steps += 1
  node = nodes[node][instructions[i]]
  break if node == 'ZZZ'
  i = (i + 1) % instructions.size
end
puts steps
