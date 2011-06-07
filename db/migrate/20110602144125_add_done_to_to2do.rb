class AddDoneToTo2do < ActiveRecord::Migration
  def change
    add_column :to2dos, :done, :boolean
  end
end
