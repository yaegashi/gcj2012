#!/usr/bin/env ruby

def rotates(a, b, w)
  ds = a.to_s
  rr = {}
  (w-1).times do
    ds = ds[w-1,1] + ds[0,w-1]
    r = ds.to_i
    rr[r] = true if r > a && r <= b
  end
  rr.size
end

gets.to_i.times do |i|
  i += 1
  a, b = gets.chomp.split.map(&:to_i)
  w = b.to_s.length
  sum = 0
  (a...b).each do |j|
    sum += rotates(j, b, w)
  end
  puts "Case ##{i}: #{sum}"
end
