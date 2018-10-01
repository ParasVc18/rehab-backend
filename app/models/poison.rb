class Poison < ApplicationRecord
  belongs_to :user
  has_many :stats

end
