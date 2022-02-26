class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.string :username
      t.string :description

      t.timestamps
    end
  end
end
