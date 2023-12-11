#!/usr/bin/env ruby

seq_ends = $stdin.readlines.map(&:strip).map do |line|
  sequence = line.split.map(&:to_i)
  sequences = []
  loop do
    break if sequence.all? { |num| num == 0 }
    sequences.push(sequence)
    sequence = sequence.each_cons(2).map { |n1, n2| n2 - n1 }
  end

  current = 0
  until sequences.empty?
    sequence = sequences.pop
    current = sequence.first - current
  end
  current
end
puts seq_ends.reduce(:+)
