#!/usr/bin/env ruby

total = 0
$stdin.readlines.each do |line|
  game_id, cubes = line.split(':')
  game_id = game_id.split.last.to_i
  maxes = {}
  cubes.split(";").each do |cube_set|
    cube_set.split(',').each do |colors|
      num, color = colors.strip.split
      num = num.to_i
      maxes[color] = if maxes.include?(color)
        [num, maxes[color]].max
      else
        num
      end
    end
  end
  total += maxes.values.reduce(:*)
end
puts total
