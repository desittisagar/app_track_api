class CreateApplyStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :apply_statuses do |t|
      t.integer :jid
      t.integer :cid
      t.string :job_title
      t.string :c_name
      t.boolean :status

      t.timestamps
    end
  end
end
