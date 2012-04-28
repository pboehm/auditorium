class FixLastSeenColumnName < ActiveRecord::Migration

  def change
    rename_column :users, :last_seen_at, :last_login
  end
end
