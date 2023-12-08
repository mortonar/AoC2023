#!/usr/bin/env ruby

time, record = 2.times.collect { $stdin.readline.split.drop(1).join.to_i }

num_ways = 0
(1..time).each do |hold|
  remaining = time - hold
  distance = hold * remaining
  num_ways += 1 if distance > record
end
puts num_ways
