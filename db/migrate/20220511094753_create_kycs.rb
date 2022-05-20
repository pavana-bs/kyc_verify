class CreateKycs < ActiveRecord::Migration[7.0]
  def change
    create_table :kycs do |t|
      t.bigint :phone_number
      t.integer :user_id
      t.string :pan_verification_response
      t.string :adhar_verification_response
      t.string :photo_verification_response
      t.timestamps
    end
  end
end
