class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :user
      t.references :post

      t.timestamps
    end
    add_index :visits, :user_id
    add_index :visits, :post_id
  end
end
