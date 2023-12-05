#!/usr/bin/env ruby

require 'set'

card_tally = {}
$stdin.readlines.each do |line|
  tokens = line.split
  _card = tokens.delete_at(0)
  card_num = tokens.delete_at(0).chomp(':').to_i
  winning = Set.new
  while (item = tokens.delete_at(0)) != '|' do
    winning << item.to_i
  end
  scratched = tokens.collect(&:to_i).to_set
  matched = (winning & scratched).size
  card_tally[card_num] = (card_tally[card_num] || 0) + 1
  if matched > 0
    (1..matched).each do |i|
      card_tally[card_num + i] = (card_tally[card_num + i] || 0) + card_tally[card_num]
    end
  end
end
puts card_tally.values.reduce(:+)
