#!/usr/bin/env ruby

num_lookup = {
  'one'   => '1',
  'two'   => '2',
  'three' => '3',
  'four'  => '4',
  'five'  => '5',
  'six'   => '6',
  'seven' => '7',
  'eight' => '8',
  'nine'  => '9',
}

total = 0
$stdin.readlines.each do |line|
  line.downcase!
  matches = line.scan(/(?=([1-9]|one|two|three|four|five|six|seven|eight|nine))/).flatten
  total += [matches.first, matches.last].map { |num| (/[1-9]/.match(num)) ? num : num_lookup[num] }.join.to_i
end
puts total
