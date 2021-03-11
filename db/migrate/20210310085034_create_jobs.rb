class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :category
      t.integer :yoe
      t.boolean :status

      t.timestamps
    end
  end
end
