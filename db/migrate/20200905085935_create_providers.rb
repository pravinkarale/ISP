class CreateProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.string :name
      t.integer :lowest_price
      t.float :rating
      t.string :max_speed
      t.text :description
      t.string :contact_no
      t.string :email
      t.string :url
      t.string :image_name
      t.string :image_path
      t.timestamps
    end
  end
end
