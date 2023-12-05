#!/usr/bin/env ruby

require 'set'

total = 0
$stdin.readlines.each do |line|
  tokens = line.split
  2.times { tokens.delete_at(0) }
  winning = Set.new
  while (item = tokens.delete_at(0)) != '|' do
    winning << item.to_i
  end
  scratched = tokens.collect(&:to_i).to_set
  matched = (winning & scratched).size
  total += 2**(matched - 1) if matched > 0
end
puts total
