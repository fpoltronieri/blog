require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  test "Verifico che un commento abbia tutti i dati" do
    comment = Comment.new(content: "Si, sono d'accordo", post_id: posts(:one).id)
    puts comment.inspect
    assert comment.save 
  end
end
