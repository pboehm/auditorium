class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :at
      t.text :description

      t.timestamps
    end
  end
end
