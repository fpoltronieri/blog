class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user # aggiunta dipendenza con User
  broadcasts_to :post 
  validates :content, presence: true, length: {minimum: 2}
  
  before_destroy :check_user

  private
  def check_user
    throw(:abort) unless Current.user == self.user
  end
end
