class CreateFeedData < ActiveRecord::Migration[5.0]
  def change
    create_table :feed_data do |t|

      t.timestamps
    end
  end
end
