#!/usr/bin/env ruby

require 'set'

# Since 1 === 1
class PartNum
  attr_accessor :num
  def initialize(num)
    @num=num
  end
end

schematic = $stdin.readlines.collect { |line| line.strip.chars.to_a }
num = ""
part_num = false
# [x, y]s the current part number occupies
num_coords = []
# Map of [x, y] => occupied PartNum
part_nums = {}
# Find part numbers
schematic.each_with_index do |line, row|
  line.each_with_index do |c, col|
    if /[0-9]/.match(c)
      num += c
      num_coords.push([row, col])
      unless part_num
        [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].each do |x, y|
          adj = schematic[row + x]
          adj = adj[col + y] if adj != nil
          if adj != nil && !/[0-9]|\./.match(adj)
            part_num = true
          end
        end
      end
    else
      if part_num
        pn = PartNum.new(num.to_i)
        num_coords.each { |coord| part_nums[coord] = pn }
      end
      num = ""
      part_num = false
      num_coords = []
    end
  end
end

# Find the gears
total = 0
schematic.each_with_index do |line, row|
  line.each_with_index do |c, col|
    if c == '*'
      adjacent = Set.new
      [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].each do |x, y|
        pn = part_nums[[row + x, col + y]]
        adjacent.add(pn) if pn != nil
      end
      total += adjacent.map{|a| a.num }.reduce(:*) if adjacent.size == 2
    end
  end
end
puts total
