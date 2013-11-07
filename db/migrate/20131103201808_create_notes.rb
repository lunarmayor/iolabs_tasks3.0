class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :text
      t.integer :job_id
      t.integer :user_id
      t.string :author

      t.timestamps
    end
  end
end
