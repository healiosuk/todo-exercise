json.extract! todo, :id, :title, :description, :user_id, :complete, :created_at, :updated_at
json.url todo_url(todo, format: :json)
