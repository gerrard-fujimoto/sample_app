require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links with not login user" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    get about_path
    assert_select "title", full_title("About")
    get help_path
    assert_select "title", full_title("Help")
  end

  test "layout links with login user" do
    log_in_as(@user)
    assert_redirected_to @user
    get root_path

    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", users_path
    assert_select "li.dropdown" do
      assert_select "a.dropdown-toggle", text: "Account"
      assert_select "ul.dropdown-menu" do
        assert_select "a[href=?]", user_path(@user), text: "Profile"
        assert_select "a[href=?]", edit_user_path(@user), text: "Settings"
        assert_select "a[href=?]", logout_path, text: "Log out"
      end
    end
  end
end
