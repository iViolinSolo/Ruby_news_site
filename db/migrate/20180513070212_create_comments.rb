class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.string :author
      t.references :schoolnews, foreign_key: true

      t.timestamps
    end
  end
end
