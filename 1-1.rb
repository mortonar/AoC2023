#!/usr/bin/env ruby

total = 0
$stdin.readlines.each do |line|
  matches = line.scan(/[1-9]/).flatten
  total += [matches.first, matches.last].join.to_i
end
puts total
