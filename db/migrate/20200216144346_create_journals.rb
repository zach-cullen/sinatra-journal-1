class CreateJournals < ActiveRecord::Migration[5.2]
  def change
    create_table :journals do |t|
      t.string :title
      t.integer :user_id
      t.boolean :archived
      t.timestamps
    end
  end
end
