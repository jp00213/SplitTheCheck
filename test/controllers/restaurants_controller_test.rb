require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @restaurant = restaurants(:one)
    @restaurant2 = restaurants(:four)
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:one)
    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurant" do
    sign_in users(:one)
    assert_difference('Restaurant.count') do
      post restaurants_url, params: { restaurant: { location: @restaurant.location, name: @restaurant.name } }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:one)
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    sign_in users(:one)
    patch restaurant_url(@restaurant), params: { restaurant: { location: @restaurant.location, name: @restaurant.name } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should destroy restaurant" do
    sign_in users(:one)
    assert_difference('Restaurant.count', -1) do
      delete restaurant_url(@restaurant2)
    end

    assert_redirected_to restaurants_url
  end

#  Tests involving controller methods: showUpvote, showDownvote
#  are found in rails test:system.


  test "should increase upvote" do
    sign_in users(:one)
    result = 0
    Review.all.each do |test|
      result = result + test.upvote
    end
    assert_equal(0, result)
    assert_difference('Review.all.count', 1) do
      put '/increaseUpvote', params: { id: @restaurant.id }
    end
    result = 0
    Review.all.each do |test|
      result = result + test.upvote
    end
    assert_equal(1, result)
  end
  
  test "should increase downvote" do
    sign_in users(:one)
    result = 0
    Review.all.each do |test|
      result = result + test.downvote
    end
    assert_equal(0, result)
    assert_difference('Review.all.count', 1) do
      put '/increaseDownvote', params: { id: @restaurant.id }
    end
    result = 0
    Review.all.each do |test|
      result = result + test.downvote
    end
    assert_equal(1, result)
  end
  
end
