require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  test "Create a new post" do
    visit posts_url
    puts page.html
    # using regex 
    #click_on /new post/i  
    click_on "New post"
    fill_in "Title", with: "My First Post, created with System Test"
    fill_in "Body", with: "This is the content of my first post."
    click_on "Create Post"
    assert_text "Post was successfully created"
  end
end
