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
    rank = ['J', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'Q', 'K', 'A']
    cards.zip(other.cards).each do |c1, c2|
      return rank.find_index(c1) <=> rank.find_index(c2) if c1 != c2
    end
    rank.find_index(cards.last) <=> rank.find_index(other.cards.last)
  end

  def calc_type
    denoms = cards.each_with_object(Hash.new(0)) { |c, denoms| denoms[c] += 1 }
    denoms = denoms.values.sort
    jokers = cards.count('J')

    if denoms == [5]
      7
    elsif denoms == [1, 4]
      # AAJAA(1) => 7, JJ8JJ(4) => 7
      jokers == 0 ? 6 : 7
    elsif denoms == [2, 3]
      # J333J(2) => 7, 2JJJ2(3) => 7
      jokers == 0 ? 5 : 7
    elsif denoms == [1, 1, 3]
      # TTT9J(1) => 6, JJJ98(3) => 6
      jokers == 0 ? 4 : 6
    elsif denoms == [1, 2, 2]
      # 23J32(1) => 5, J343J(2) => 6
      jokers == 0 ? 3 : (jokers == 1 ? 5 : 6)
    elsif denoms == [1, 1, 1, 2]
      # A23AJ(1) => 4, J23J4(2) => 4
      jokers == 0 ? 2 : (jokers == 1 ? 4 : 4)
    else
     # 2345J: 1 => 2
     jokers == 0 ? 1 : 2
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
