#!/usr/bin/env ruby

limits = {
  "red"   => 12,
  "green" => 13,
  "blue"  => 14,
}

total = 0
$stdin.readlines.each do |line|
  game_id, cubes = line.split(':')
  game_id = game_id.split.last.to_i
  possible = true
  cubes.split(";").each do |cube_set|
    cube_set.split(',').each do |colors|
      num, color = colors.strip.split
      possible = num.to_i <= limits[color]
      break unless possible
    end
    break unless possible
  end
  total += game_id if possible
end
puts total
