class CreateBugs < ActiveRecord::Migration
  def self.up
    create_table :bugs do |t|
      t.string :description
      t.string :status
      t.integer :developer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bugs
  end
end
