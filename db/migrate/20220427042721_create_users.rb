class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :country_code
      t.bigint :phone_number
      t.string :name
      t.string :verification_code
      t.timestamps
    end
  end
end
