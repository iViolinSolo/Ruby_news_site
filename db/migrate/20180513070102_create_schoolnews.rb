class CreateSchoolnews < ActiveRecord::Migration[5.1]
  def change
    create_table :schoolnews do |t|
      t.text :title
      t.string :source
      t.string :author

      t.timestamps
    end
  end
end
