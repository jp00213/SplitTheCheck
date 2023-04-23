require "test_helper"

class RestaurantTest < ActiveSupport::TestCase

  test "should search for My" do
    @restaurants = Restaurant.search("My")
    assert_equal(3, @restaurants.count)
  end

  test "should search for Your" do
    @restaurants = Restaurant.search("Your")
    assert_equal(1, @restaurants.count)
  end

  test "should search for empty string" do
    @restaurants = Restaurant.search("")
    assert_equal(4, @restaurants.count)
  end

  test "should search for Junk" do
    @restaurants = Restaurant.search("Junk")
    assert_equal(0, @restaurants.count)
  end

  test "should show correct values for upvote" do
    assert_equal(0, Restaurant.showUpvote(@restaurant))
    @restaurant = restaurants(:one)
    @user = users(:one)
    Review.create(restaurant: @restaurant, user: @user, upvote: 1, downvote: 0)
    assert_equal(1, Restaurant.showUpvote(@restaurant))
    Review.create(restaurant: @restaurant, user: @user, upvote: 1, downvote: 1)
    assert_equal(2, Restaurant.showUpvote(@restaurant))
  end
  
  test "should show correct values for downvote" do
    assert_equal(0, Restaurant.showDownvote(@restaurant))
    @restaurant = restaurants(:one)
    @user = users(:one)
    Review.create(restaurant: @restaurant, user: @user, upvote: 0, downvote: 1)
    assert_equal(1, Restaurant.showDownvote(@restaurant))
    Review.create(restaurant: @restaurant, user: @user, upvote: 1, downvote: 1)
    assert_equal(2, Restaurant.showDownvote(@restaurant))
  end

end
