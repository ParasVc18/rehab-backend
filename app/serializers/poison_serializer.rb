class PoisonSerializer < ActiveModel::Serializer
  attributes :id, :name, :dose_size, :dose_type, :no_of_doses, :price_of_doses, :currency, :time_period, :time_type, :avg_value, :alpha, :progress, :counter, :spent, :total
  has_many :stats
end