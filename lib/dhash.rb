require 'dhash/version'
require "vips"

module Dhash extend self
  def hamming(a, b)
    (a^b).to_s(2).count('1')
  end

  def calculate(file, size = 8)
    image = image.resize((size + 1).fdiv(image.width), vscale: size.fdiv(image.height)).colourspace("b-w").flatten
    pixel_array =image.to_a.map &:flatten
    difference = []

    size.times do |row|
      size.times do |col|
        pixel_left = pixel_array[row][col]
        pixel_right = pixel_array[row][col + 1]
        difference << (pixel_left > pixel_right)
      end
    end
  end
end
