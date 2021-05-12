class CreateApiRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :api_requests do |t|
      t.references :user, null: true, foreign_key: true
      t.string :endpoint
      t.string :remote_ip
      t.string :payload

      t.timestamps
    end
  end
end
