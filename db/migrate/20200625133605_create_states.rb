class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.string :name
      t.float :lat
      t.float :long
      t.integer :zoom

      t.timestamps
    end
  end
end
