require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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

end
