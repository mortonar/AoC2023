#!/usr/bin/env ruby

times, distances = 2.times.collect {$stdin.readline.split.drop(1).collect(&:to_i) }

total = 1
times.zip(distances).each do |time, record|
  num_ways = 0
  (1..time).each do |hold|
    remaining = time - hold
    distance = hold * remaining
    num_ways += 1 if distance > record
  end
  total *= num_ways
end
puts total
