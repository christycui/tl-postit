class RenameCatogoryToCategory < ActiveRecord::Migration
  def change
    rename_table :catogories, :categories
  end
end
