require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:testuser)
    @other_user = users(:archer)
    @existing_book = books(:gatsby)
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { password: 'password',
                                            password_confirmation: 'password',
                                            admin: true }
    assert_not @other_user.reload.admin?
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when logged in as non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end
  
  test "should add book from db to user" do
    log_in_as(@user)
    assert_not @user.on_list?(@existing_book)
    post :add_book_to_list, id: @user, book_id: @existing_book
    assert @user.on_list?(@existing_book)
    assert_not flash.empty?
    assert_redirected_to @user
  end
  
  # Include test of invalid api book addition
  
  test "should add book from api" do
    log_in_as(@user)
    assert_not Book.find_by(openlibrary_key: "/works/notakey")
    book_params = { :title => "foo", :author => "bar",
                    :thumbnail_url => "http://placehold.it/120x120&text=image1",
                    :openlibrary_key => "/works/234432",
                    :first_publish_year => 1901 }
    post :add_book_from_api, id: @user, book_params: book_params
    assert_not flash.empty?
    assert Book.find_by(openlibrary_key: "/works/234432")
    added_book = Book.find_by(openlibrary_key: "/works/234432")
    assert @user.on_list?(added_book)
  end
end
