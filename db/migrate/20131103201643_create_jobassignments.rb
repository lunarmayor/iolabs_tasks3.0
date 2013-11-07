class CreateJobassignments < ActiveRecord::Migration
  def change
    create_table :jobassignments do |t|
      t.integer :user_id
      t.integer :job_id

      t.timestamps
    end
  end
end
