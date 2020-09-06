class CreateProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.string :name
      t.integer :lowest_price
      t.float :rating
      t.integer :max_speed
      t.text :description
      t.string :contact_no
      t.string :email
      t.string :url
      t.string :image
      t.timestamps
    end
  end
end
