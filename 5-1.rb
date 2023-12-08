#!/usr/bin/env ruby

class Map
  attr_accessor :source_ranges, :dest_ranges

  def initialize
    @source_ranges = []
    @dest_ranges = []
  end

  def map(val)
    source_ranges.each_with_index do |sr, i|
      if sr.include?(val)
        return dest_ranges[i].first + (val - sr.first)
      end
    end
    return val
  end
end

seeds = $stdin.readline.split
seeds.delete_at(0)
seeds.collect!(&:to_i)
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

locations = seeds.each.collect do |seed|
  maps.inject(seed) { |val, m| m.map(val) }
end
puts locations.min
