require "test_helper"

class TriviaFormControllerTest < ActionDispatch::IntegrationTest
  test "should get trivia_form" do
    get trivia_form_trivia_form_url
    assert_response :success
  end
end
