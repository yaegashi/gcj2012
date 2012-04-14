#!/usr/bin/env ruby

def rotates(a, b)
  w = b.to_s.length
  ds = a.to_s.unpack("c*").map{|i|i-?0.ord}
  while ds.length < w
    ds.unshift(0)
  end
  rr = []
  (w-1).times do
    ds = ds.rotate(-1)
    rr << ds.map{|i|i+?0.ord}.pack("c*").to_i
  end
  c = 0
  rr.sort.uniq.each do |r|
    c += 1 if r > a && r <= b
  end
  c
end
  
gets.to_i.times do |i|
  a, b = gets.chomp.split.map(&:to_i)
  sum = (a...b).map{|j|rotates(j,b)}.reduce(:+)
  puts "Case ##{i}: #{sum}"
end
