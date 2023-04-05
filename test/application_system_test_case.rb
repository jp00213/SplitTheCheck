require "test_helper"
require "capybara"
require'helpers/firefox_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :headless_firefox
end
