# app/helpers/likes_helper.rb
module LikesHelper
  def liked_by_current_user?(likeable)
    return false unless Current.user
    Like.exists?(user_id: Current.user.id,
                 likeable: likeable)
  end
end

