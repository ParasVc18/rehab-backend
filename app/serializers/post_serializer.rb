class PostSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_many :comments
  has_many :likes
end
