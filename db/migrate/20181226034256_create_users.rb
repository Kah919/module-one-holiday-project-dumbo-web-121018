class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :User do |t|
      t.string :name
      t.integer :age
      t.integer :weight
    end
  end
end
