class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.integer :position
      t.string :name

      t.timestamps
    end
  end
end
