alice = User.find_or_create_by!(email: "alice@example.com") do |u|
  u.first_name = "Alice"
  u.last_name  = "Smith"
end

bob = User.find_or_create_by!(email: "bob@example.com") do |u|
  u.first_name = "Bob"
  u.last_name  = "Jones"
end

[
  { user: alice, title: "Buy groceries",    description: "Milk, eggs, bread",           complete: false },
  { user: alice, title: "Book dentist",     description: "6-month check-up",            complete: true  },
  { user: bob,   title: "Write tests",      description: "Cover models and controllers", complete: true  },
  { user: bob,   title: "Review PR",        description: "Check the auth changes",       complete: false },
  { user: bob,   title: "Update README",    description: "Add setup instructions",       complete: false },
].each do |attrs|
  Todo.find_or_create_by!(title: attrs[:title], user: attrs[:user]) do |t|
    t.description = attrs[:description]
    t.complete    = attrs[:complete]
  end
end
