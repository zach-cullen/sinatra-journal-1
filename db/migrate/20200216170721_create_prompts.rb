class CreatePrompts < ActiveRecord::Migration[5.2]
  def change
    create_table :prompts do |t|
      t.string :title
      t.integer :journal_id
      t.boolean :archived
      t.timestamps
    end
  end
end
