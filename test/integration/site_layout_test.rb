require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
  #  @user = users(:michael)
  @admin = users(:michael)
  @non_admin = users(:archer)
  end


  test "layout links" do

    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count:2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
      #added for exercise 9.2
       log_in_as(@admin)
      #  assert_select 'a', text: 'delete', count: 0
      assert_select 'a[href=?]', user_path(@admin), text: 'Delete', count: 0
      #end exercise

    get signup_path
  # part of exercise Ch5.3 , instead of this: ....... made an appl.helper.test-file.
  #  assert_select "title", full_title("Sign up")

  end
end
