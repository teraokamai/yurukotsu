require 'test_helper'

class RecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get records_index_url
    assert_response :success
  end

  test "should get edit" do
    get records_edit_url
    assert_response :success
  end

end
