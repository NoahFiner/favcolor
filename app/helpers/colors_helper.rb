module ColorsHelper
  # don't include the # here
  def hexToRgb(hex)
    result = []
    hex.to_s.scan(/../).each {|c| result.append(c.to_i(16))}
    result
  end

  def rgbToHex(rgb_arr)
    result = ""
    rgb_arr.each {|component| result += component.to_s(16) }
    if result.length == 5
      result.prepend("0")
    end
    result
  end

  def lighten_hex(hex, amt)
    rgb = hexToRgb(hex)
    result = []
    rgb.each do |color|
      color += amt
      color = 255 if color > 255
      result.append(color.to_i)
    end
    rgbToHex(result)
  end
end
