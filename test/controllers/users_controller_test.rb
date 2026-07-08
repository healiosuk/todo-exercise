require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:alice)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { first_name: "Carol", last_name: "White", email: "carol@example.com" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "show displays the user's todos" do
    get user_url(@user)
    assert_select "td", text: todos(:buy_milk).title
  end

  test "user show has complete button for incomplete todos" do
    get user_url(@user)
    assert_select "form[action='#{todo_path(todos(:buy_milk))}']"
  end

  test "user show has no complete button for already complete todos" do
    get user_url(users(:bob))
    assert_select "form[action='#{todo_path(todos(:write_tests))}']", count: 0
  end

  test "show displays no todos message when user has none" do
    user = User.create!(first_name: "Empty", last_name: "User", email: "empty@example.com")
    get user_url(user)
    assert_select "p", text: "No todos yet."
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { first_name: "Alicia", last_name: @user.last_name, email: @user.email } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
