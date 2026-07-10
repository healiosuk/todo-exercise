class AddDueDateAndPriorityToTodos < ActiveRecord::Migration[8.1]
  def change
    add_column :todos, :due_date, :date
    add_column :todos, :priority, :string, default: "medium"
  end
end
