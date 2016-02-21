class Color < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :color, presence: true, length: {is: 6}, format: {with: /([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})/}
  validates :description, length: {maximum: 100}
end
