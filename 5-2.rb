#!/usr/bin/env ruby

require 'set'

class Range

  # => [intersection, [remainder(s)]] both parts could be nil
  def subdivide(other)
    return [nil, [self]] if last < other.first || other.last < first

    intersection = ([first, other.first].max..[last, other.last].min)

    remainders = []
    remainders << (first..(other.first - 1)) if first < other.first
    remainders << ((other.last + 1)..last) if last > other.last
    [intersection, remainders]
  end
end

class Map
  attr_accessor :source_ranges, :dest_ranges

  def initialize
    @source_ranges = []
    @dest_ranges = []
  end

  def map(ranges)
    mapped_ranges = Set.new

    to_map = ranges.to_a
    until to_map.empty?
      r = to_map.pop
      mapped = false
      remainders = Set.new
      source_ranges.each_with_index do |sr, i|
        intersection, remainder = r.subdivide(sr)
        if intersection
          mapped_start = dest_ranges[i].first + (sr.first - intersection.first).abs
          mapped_end = mapped_start + intersection.last - intersection.first
          mapped_ranges << (mapped_start..mapped_end)
          mapped = true
        end
        unless remainder.empty?
          remainder.each { |rem| remainders << rem if rem != r }
        end
      end
      remainders.each { |rem| to_map << rem }
      mapped_ranges << r unless mapped
    end
    mapped_ranges
  end
end

seed_ranges = Set.new
seeds = $stdin.readline.split
seeds.delete_at(0)
seeds.collect!(&:to_i)
seeds.each_slice(2) do |start, length|
  seed_ranges << (start..start + length - 1)
end
$stdin.readline

maps = []
map = nil
$stdin.readlines.each do |line|
  tokens = line.split
  if tokens.empty?
    # No-op
  elsif tokens.include?("map:")
    map = Map.new
    maps << map
  else
    dest, source, length = tokens.collect(&:to_i)
    map.dest_ranges << (dest..dest + length)
    map.source_ranges << (source..source + length)
  end
end

res_ranges = seed_ranges
maps.each do |m|
  res_ranges = m.map(res_ranges)
end
puts res_ranges.collect(&:first).min
