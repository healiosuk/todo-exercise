require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = todos(:buy_milk)
    @user = users(:alice)
  end

  test "should get index" do
    get todos_url
    assert_response :success
  end

  test "index shows complete button for incomplete todos" do
    get todos_url
    assert_select "form[action='#{todo_path(todos(:buy_milk))}']"
  end

  test "index does not show complete button for already complete todos" do
    get todos_url
    assert_select "form[action='#{todo_path(todos(:write_tests))}']", count: 0
  end

  test "completing a todo via patch marks it done" do
    patch todo_url(@todo), params: { todo: { complete: true } }
    assert @todo.reload.complete
  end

  test "index shows user full name linked to user page" do
    get todos_url
    assert_select "a[href='#{user_path(@user)}']", text: @user.full_name
  end

  test "should get new" do
    get new_todo_url
    assert_response :success
  end

  test "should create todo" do
    assert_difference("Todo.count") do
      post todos_url, params: { todo: { title: "New task", description: "Details", user_id: @user.id, complete: false } }
    end

    assert_redirected_to todo_url(Todo.last)
  end

  test "should show todo" do
    get todo_url(@todo)
    assert_response :success
  end

  test "show displays user full name linked to user page" do
    get todo_url(@todo)
    assert_select "a[href='#{user_path(@user)}']", text: @user.full_name
  end

  test "should get edit" do
    get edit_todo_url(@todo)
    assert_response :success
  end

  test "should update todo" do
    patch todo_url(@todo), params: { todo: { title: "Updated title", description: @todo.description, user_id: @todo.user_id, complete: true } }
    assert_redirected_to todo_url(@todo)
  end

  test "should destroy todo" do
    assert_difference("Todo.count", -1) do
      delete todo_url(@todo)
    end

    assert_redirected_to todos_url
  end
end
