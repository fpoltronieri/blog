require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  test "Verifichiamo che title e body siano presenti" do
    post = Post.new 
    puts "Post creato in test: #{post.inspect}"
    ### assert 
    assert_not post.valid?
  end

  test "Non possono esserci post con più di 128 caratteri" do 
    post = Post.new(title: "Nuovo post", body: "f" * 130)
    assert_not post.save
  end

  include FactoryBot::Syntax::Methods
  test "Vado a verificare che un post abbia almeno tre commenti" do
    post = create(:post_with_comments, comments_count: 3)
    puts post.inspect
    post.comments.each do |comment|
      puts comment.inspect
    end

    assert_equal 3, post.comments.count
  end
end
