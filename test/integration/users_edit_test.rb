require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "invalid edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
  end

  test "successfull edit with friendly forwading" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Mike Example"
    email = "mike@example.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
