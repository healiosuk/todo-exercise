require "test_helper"

class TodoTest < ActiveSupport::TestCase
  setup do
    @todo = todos(:buy_milk)
  end

  test "belongs to a user" do
    assert_respond_to @todo, :user
    assert_equal users(:alice), @todo.user
  end

  test "is invalid without a user" do
    todo = Todo.new(title: "Orphan", description: "No owner")
    assert_not todo.valid?
    assert_includes todo.errors[:user], "must exist"
  end

  test "complete defaults to false" do
    todo = Todo.create!(title: "Fresh task", description: "New", user: users(:bob))
    assert_equal false, todo.complete
  end

  test "can be marked complete" do
    @todo.update!(complete: true)
    assert @todo.reload.complete
  end
end
