require "application_system_test_case"

class RestaurantsTest < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:one)
    @user = User.create(email: "myemail@email.com", password: 12345678)
  end

  test "visiting the index" do
    visit restaurants_url
    assert_selector "h1", text: "WILL THEY SPLIT?"
  end

  test "creating a Restaurant" do
    visit restaurants_url
    click_on "Sign In"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Log in"

    click_on "New Restaurant"
    fill_in "Location", with: @restaurant.location
    fill_in "Name", with: @restaurant.name
    click_on "Create Restaurant"

    assert_text "Restaurant was successfully created"
    click_on "Back"
  end

  test "updating a Restaurant" do
    visit restaurants_url
    click_on "Sign In"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Log in"

    click_on "Edit", match: :first

    fill_in "Location", with: @restaurant.location
    fill_in "Name", with: @restaurant.name
    click_on "Update Restaurant"

    assert_text "Restaurant was successfully updated"
    click_on "Back"
  end

  # Tests showUpvote and showDownvote before button presses
  test "display initial up and down votes" do
    visit restaurants_url
    assert_selector "td", :text => "My Diner".to_s
    assert_selector "td", :text => "Atlanta, GA".to_s
    assert_selector "td", :text => "0".to_s
    assert_selector "td", :text => "0".to_s
  end

  # Tests showUpvote and showDownvote after button presses
  test "display increased up and down votes" do
    visit restaurants_url
    click_on "Sign In"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Log in"

    click_on "Will Split", match: :first
    click_on "Will Split", match: :first
    click_on "Won't Split", match: :first
    click_on "Won't Split", match: :first
    click_on "Won't Split", match: :first
    assert_selector "td", :text => "My Diner".to_s
    assert_selector "td", :text => "Atlanta, GA".to_s
    assert_selector "td", :text => "2".to_s
    assert_selector "td", :text => "3".to_s
  end
  
  test "adding a comment" do
    visit restaurants_url
    click_on "Sign In"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Log in"
    
    click_on "Show", match: :first
    click_on "Add Comment"

    fill_in "fullComment", with: "Test Comment"
    click_on "Save"

    assert_text "Comment successfully added"
    click_on "Back"
  end

  test "viewing summary" do
    visit restaurants_url
    click_on "Sign In"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "Log in"
    
    click_on "Your Summary"

    assert_text "Your Comments"
    click_on "Back"
  end


end
