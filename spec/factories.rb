# By using the symbol ':bug', we get Factory Girl to simulate the Bug model.
Factory.define :bug do |bug|
  bug.description    "Test bug"
  bug.status         "New"
  bug.developer_id   "1" 
end

Factory.define :developer do |developer|
  developer.id      "1"
  developer.name    "Test developer"
end

