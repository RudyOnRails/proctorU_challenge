class CreateColleges < ActiveRecord::Migration[6.1]
  def change
    create_table :colleges do |t|

      t.timestamps
    end
  end
end
