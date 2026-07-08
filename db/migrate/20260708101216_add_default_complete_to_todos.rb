class AddDefaultCompleteToTodos < ActiveRecord::Migration[8.1]
  def change
    change_column_default :todos, :complete, from: nil, to: false
  end
end
