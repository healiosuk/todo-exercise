require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:alice)
  end

  test "full_name joins first and last name" do
    assert_equal "Alice Smith", @user.full_name
  end

  test "has many todos" do
    assert_respond_to @user, :todos
    assert_includes @user.todos, todos(:buy_milk)
  end

  test "destroying a user destroys their todos" do
    todo_id = todos(:buy_milk).id
    @user.destroy
    assert_not Todo.exists?(todo_id)
  end
end
