module Likeable extend ActiveSupport::Concern

  def current_user_like
    Current.user&.likes&.find_by(likeable: self)
  end

  def liked_by_current_user?
    current_user_like.present?
  end

  def likes_count
    likes.size
  end
end
