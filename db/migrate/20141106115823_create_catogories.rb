class CreateCatogories < ActiveRecord::Migration
  def change
    create_table :catogories do |t|
      t.string :name
      t.timestamps
    end
  end
end
