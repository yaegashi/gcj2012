#!/usr/bin/env ruby

require 'pp'

def divide(score)
  a = b = c = score / 3
  case score % 3
  when 0
    x, y, z = a+1, b, c-1
  when 1
    a += 1
    x, y, z = a, b+1, c-1
  when 2
    a += 1
    b += 1
    x, y, z = a+1, b-1, c
  end
  x, y, z = a, b, c if x > 10 || y > 10 || y < 0 || z < 0
  return [a, b, c], [x, y, z]
end

table = []
(0..30).each do |i|
  table[i] = divide(i)
end

gets.to_i.times do |i|
  i += 1
  line = gets.chomp
  nspo = line.split(" ", 4)
  n, s, p = nspo.map(&:to_i)
  o = nspo.last.split.map(&:to_i)
  abort "Wrong input: #{line} at #{i}" unless n == o.size
  r = 0
  o.each do |j|
    abort "Wrong input: #{line} at #{i}" unless 0 <= j && j <= 30
    s0, s1 = table[j]
    if s0[0] >= p
      r += 1
      next
    end
    if s1[0] >= p && s > 0
      r += 1
      s -= 1
      next
    end
  end
  puts "Case ##{i}: #{r}"
  #puts "Case ##{i}: #{r} (#{n} #{s} #{p} #{o.inspect})"
end
