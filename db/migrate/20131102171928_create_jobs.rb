class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :status
      t.string :iolabs_due_date
      t.string :client_due_date

      t.timestamps
    end
  end
end
