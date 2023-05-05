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
  
  test "should display summary page" do
    sign_in users(:one)
    put summary_path
    assert_response :success
  end

  test "should add a new comment on a restaurant" do
    sign_in users(:one)
    get restaurant_url(@restaurant)
    get newComment_path(:restaurant => @restaurant)
    assert_response :success
    @comment = Comment.where("restaurant_id == ?", @restaurant)
    assert_equal(1, @comment.size)

    post newComment_path(:restaurant => @restaurant, :fullComment => "testing")
    @comment = Comment.where("restaurant_id == ?", @restaurant)
    assert_equal(2, @comment.size)
    assert_equal("testing", @comment[1].fullComment)
  end

  test "should set and unset a restaurant as favorite" do
    sign_in users(:one)
    get restaurant_url(@restaurant)

    @favorites = Favorite.where("restaurant_id == ?", @restaurant)
    assert(!@favorites[0].isFavorite)
    post toggleFavorite_path(:restaurant => @restaurant)
    @favorites = Favorite.where("restaurant_id == ?", @restaurant)
    assert(@favorites[0].isFavorite)
    post toggleFavorite_path(:restaurant => @restaurant)
    @favorites = Favorite.where("restaurant_id == ?", @restaurant)
    assert(!@favorites[0].isFavorite)
  end

end
