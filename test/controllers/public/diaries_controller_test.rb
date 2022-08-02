require "test_helper"

class Public::DiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_diaries_index_url
    assert_response :success
  end

  test "should get show" do
    get public_diaries_show_url
    assert_response :success
  end

  test "should get new" do
    get public_diaries_new_url
    assert_response :success
  end

  test "should get create" do
    get public_diaries_create_url
    assert_response :success
  end

  test "should get update" do
    get public_diaries_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_diaries_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get public_diaries_edit_url
    assert_response :success
  end
end
