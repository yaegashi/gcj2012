#!/usr/bin/env ruby

require 'pp'

class Hall

  def initialize(io)
    @h, @w, @d = io.gets.chomp.split.map(&:to_i)
    @m = []
    @h.times do |i|
      m = io.gets.chomp.split("")
      @m << m
      if j = m.find_index("X")
        @sx = j
        @sy = i
      end
    end
  end

  def getc(x, y)
    @m[y][x]
  end

  def disp
    puts "D:#{@d} X:(#{@sx},#{@sy})"
    @m.each do |i|
      puts i.join
    end
  end

  def distance(n, m)
    n2 = n * n
    m2 = m * m
    r = []
    if n <= m
      r << [n, 0]
    end
    (1..n-1).each do |i|
      next unless i*i + n2 <= m2
      r << [n, i]
    end
    r << [n, n] if n2 + n2 <= m2
    r
  end

  def distances(m)
    r = []
    (1..m).each do |i|
      r += distance(i, m)
    end
    r
  end

  def crossings(dx, dy)
    if dx.zero?
      r = [[0, 1]]*dy
      d = [[0,1], [0,-1]]
    elsif dy.zero?
      r = [[1, 0]]*dx
      d = [[1,0], [-1,0]]
    else
      r = []
      d = [[1,1], [-1,1], [-1,-1], [1,-1]]
      z = dx*dy
      mx = my = 0
      u = v = z
      while !(mx == dx && my == dy)
        x0y = v - u * dy / dx
        y0x = u - v * dx / dy
        if x0y > 0
          mx += 1
          u = 2*z
          v = x0y
          r << [1, 0]
        elsif y0x > 0
          my += 1
          u = y0x
          v = 2*z
          r << [0, 1]
        else
          mx += 1
          my += 1
          u = v = 2*z
          r << [1, 1]
        end
      end
    end
    [r, d]
  end

  def trace1(ca, dir)
    dx, dy = dir
    mx = @sx
    my = @sy
    ca.each do |cx, cy|
      if cx > 0 && cy > 0
        if getc(mx+dx, my+dy) == "#"
          wx = getc(mx+dx, my)
          wy = getc(mx, my+dy)
          if wx == "#" && wy == "#"
            dx = -dx
            dy = -dy
          elsif wx == "#" && wy != "#"
            dx = -dx
            my += dy
          elsif wx != "#" && wy == "#"
            mx += dx
            dy = -dy
          else
            return false
          end
        else
          mx += dx
          my += dy
        end
      elsif cx > 0
        if getc(mx+dx, my) == "#"
          dx = -dx
        else
          mx += dx
        end
      elsif cy > 0
        if getc(mx, my+dy) == "#"
          dy = -dy
        else
          my += dy
        end
      end
    end
    getc(mx, my) == "X"
  end

  def trace2(ca, dirs, dx, dy)
    dirs.each do |sx, sy|
      if trace1(ca, [sx, sy])
        indep = false
        ax = dx*sx
        ay = dy*sy
        aa = ax*ax+ay*ay
        @r.each do |bx, by|
          prod = ax*bx+ay*by
          if prod > 0 && prod*prod == aa*(bx*bx+by*by)
            indep = true
            break
          end
        end
        @r << [ax, ay] unless indep
      end
    end
  end

  def traces
    @r = []
    distances(@d).each do |dx, dy|
      ca0, dirs0 = crossings(dx, dy)
      trace2(ca0, dirs0, dx, dy)
      unless dx == dy
        ca1 = ca0.map(&:reverse)
        dirs1 = dirs0.map(&:reverse)
        trace2(ca1, dirs1, dy, dx)
      end
    end
    @r
  end

end

gets.to_i.times do |i|
  i += 1
  h = Hall.new(ARGF)
  puts "Case ##{i}: #{h.traces.size}"
end
