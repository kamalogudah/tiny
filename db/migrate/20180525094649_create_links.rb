class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :original
      t.string :url_code

      t.timestamps
    end
  end
end
