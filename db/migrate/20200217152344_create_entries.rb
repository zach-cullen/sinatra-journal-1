class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :prompts do |t|
      t.string :title
      t.integer :prompt_id
      t.timestamps
    end
  end
end
