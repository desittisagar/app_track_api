class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :age
      t.integer :yoe
      t.string :skills
      t.bigint :phone, null: false
      t.string :password_digest

      t.timestamps
    end
  end
end
