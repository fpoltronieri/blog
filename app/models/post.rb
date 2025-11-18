class Post < ApplicationRecord
  include Likeable
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :user # aggiunta dipendenza con User 
  broadcasts_to ->(post) { "posts" }

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10, maximum: 128 }

end
