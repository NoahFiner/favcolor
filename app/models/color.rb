class Color < ActiveRecord::Base
  # before_save :saveRgb
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :hex, presence: true, length: {is: 6}, format: {with: /([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})/}
  validates :description, length: {maximum: 100}

  private
    # don't include the # here
    def saveRgb(hex)
      result = []
      hex.to_s.scan(/../).each {|c| result.append(c.to_i(16))}
      update_attribute(:rgb, result.join(","))
    end

    def getRgbToHex(rgb_str)
      rgb_arr = rgb_str.split(",")
      result = ""
      rgb_arr.each {|component| result += component.to_s(16) }
      if result.length == 5
        result.prepend("0")
      end
      result
    end

end
