# By using the symbol ':bug', we get Factory Girl to simulate the Bug model.
Factory.define :bug do |bug|
  bug.title          "Test title"
  bug.description    "Test bug"
  bug.status         "New"
  bug.developer_id   "1" 
end

Factory.define :developer do |developer|
  developer.id      "1"
  developer.name    "Test developer"
end

Factory.sequence :description do |n|
  "Testing Bug#{n}"
end

Factory.sequence :name do |n|
  "Testing Developer#{n}"
end

Factory.sequence :developer_id do |n|
  n + 3
end

