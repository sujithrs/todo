class CreateTo2dos < ActiveRecord::Migration
  def change
    create_table :to2dos do |t|
      t.string :content

      t.timestamps
    end
  end
end
