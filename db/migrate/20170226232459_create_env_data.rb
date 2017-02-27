class CreateEnvData < ActiveRecord::Migration[5.0]
  def change
    create_table :env_data do |t|
      t.integer :thing_id
      t.decimal :humidity, precision: 5, scale: 2
      t.decimal :temp_c, precision: 5, scale: 2
      t.decimal :temp_f, precision: 5, scale: 2
      t.integer :entry_id

      t.timestamps
    end

    add_index :env_data, :entry_id, unique: true
    add_index :env_data, :thing_id
  end
end
