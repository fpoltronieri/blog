class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user # aggiunta dipendenza con User 
  broadcasts_to ->(post) { "posts" }

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10, maximum: 128 }

end
