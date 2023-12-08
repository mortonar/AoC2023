#!/usr/bin/env ruby

class Hand
  attr_accessor :cards, :bid, :type

  def initialize(cards, bid)
    @cards = cards
    @bid = bid
    @type = calc_type
  end

  def <=>(other)
    return type <=> other.type if type != other.type
    rank = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
    cards.zip(other.cards).each do |c1, c2|
      return rank.find_index(c1) <=> rank.find_index(c2) if c1 != c2
    end
    rank.find_index(cards.last) <=> rank.find_index(other.cards.last)
  end

  def calc_type
    denoms = cards.each_with_object(Hash.new(0)) { |c, denoms| denoms[c] += 1 }
    denoms = denoms.values.sort

    @type = if denoms == [5]
      7
    elsif denoms == [1, 4]
      6
    elsif denoms == [2, 3]
      5
    elsif denoms == [1, 1, 3]
      4
    elsif denoms == [1, 2, 2]
      3
    elsif denoms == [1, 1, 1, 2]
      2
    else
      1
    end
  end
end

hands = $stdin.readlines.map(&:split).collect do |cards, bid|
  Hand.new(cards.chars.to_a, bid.to_i)
end
hands.sort!
total = 0
hands.each_with_index { |h, rank| total += h.bid * (rank + 1) }
puts total
