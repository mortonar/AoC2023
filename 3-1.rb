#!/usr/bin/env ruby

total = 0
schematic = $stdin.readlines.collect { |line| line.strip.chars.to_a }
num = ""
part_num = false
schematic.each_with_index do |line, row|
  line.each_with_index do |c, col|
    if /[0-9]/.match(c)
      num += c
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
        total += num.to_i
      end
      num = ""
      part_num = false
    end
  end
end
puts total
