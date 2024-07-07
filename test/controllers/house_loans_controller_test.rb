require "test_helper"

class HouseLoansControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get house_loan_new_url
    assert_response :success
  end

  test "should get create" do
    get house_loan_create_url
    assert_response :success
  end
end
