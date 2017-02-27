class AddThingIdIndexToEnvData < ActiveRecord::Migration[5.0]
  def change
    add_index :env_data, :thing_id
  end
end
