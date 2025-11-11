module Likeable extend ActiveSupport::Concern

  included do 
    has_many :likes, as: :likeable, dependent: :destroy
  end 

  def current_user_like
    return nil unless Current.user
    likes.detect { |like| like.user_id == Current.user.id }
  end

  def liked_by_current_user?
    puts "Il like è presente" if current_user_like.present?
    current_user_like.present?
  end

  def likes_count
    likes.size
  end

end
