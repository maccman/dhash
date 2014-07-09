require "dhash/version"
require "rmagick"

module DHash extend self
  def hamming(a, b)
    (a^b).to_s(2).count('1')
  end

  def calculate(file)
    img = Magick::ImageList.new(file)
    img = img.set_channel_depth(Magick::AllChannels, 8)
    img = img.quantize(256, Magick::Rec601LumaColorspace)
    img = img.resize(8, 8)

    pixels = img.get_pixels(0, 0, 8, 8)
    pixels = pixels.map {|pixel| pixel.red & 255 }
    result = []

    pixels.each_with_index do |pixel, index|
      brighter = pixel > (pixels[index + 1] || 0)
      result << (brighter ? 1 : 0)
    end

    result.join('').to_i(2)
  end
end
