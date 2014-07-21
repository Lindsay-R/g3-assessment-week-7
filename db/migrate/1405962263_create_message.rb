class CreateMessage < ActiveRecord::Migration
  def up
    create_table :message do |t|
      t.string :name
      t.string :message
    end
  end

  def down
    drop_table :message
  end
end
