class RenameEventAtToTime < ActiveRecord::Migration
  def change
    rename_column :events, :at, :time
  end
end
