class AddTitleToBugs < ActiveRecord::Migration
  def self.up
    add_column :bugs, :title, :string
  end

  def self.down
    remove_column :bugs, :title
  end
end
