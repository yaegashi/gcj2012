#!/usr/bin/env ruby

require 'pp'

INPUT = <<EOF
ejp mysljylc kd kxveddknmc re jsicpdrysi
rbcpc ypc rtcsra dkh wyfrepkym veddknkmkrkcd
de kr kd eoya kw aej tysr re ujdr lkgc jv
qz
EOF

OUTPUT = <<EOF
our language is impossible to understand
there are twenty six factorial possibilities
so it is okay if you want to just give up
zq
EOF

def make_tr(input, output)

  x = ""
  y = ""
  table = {}

  input.length.times do |i|
    a = input[i]
    b = output[i]
    if table[a]
      abort "Wrong mapping '#{a}' to '#{b}' at #{i}" if table[a] != b
    else
      table[a] = b
    end
  end

  ("a".."z").each do |i|
    abort "Missing mapping for '#{i}'" unless table[i]
    x += i
    y += table[i]
  end

  return x, y

end

x, y = make_tr(INPUT, OUTPUT)
n = gets.to_i

n.times do |i|
  input = gets
  output = input.tr(x, y)
  puts "Case ##{i+1}: #{output}"
end
