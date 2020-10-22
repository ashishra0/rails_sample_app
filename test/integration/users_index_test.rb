require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:ashish)
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test "delete links should not appear to non-admin users" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    get users_path
    assert_template 'users/index'
    User.paginate(page: 1).each do |user|
      assert_select "a[href=?]", user_path(user), text: 'delete', method: :delete, count: 0
    end
  end

  test "admin should be able to delete users" do
    log_in_as(@user)
    assert @user.admin?
    get users_path
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
  end
end
