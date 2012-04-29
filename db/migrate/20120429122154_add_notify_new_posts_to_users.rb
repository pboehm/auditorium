class AddNotifyNewPostsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notify_new_posts, :boolean, :default => true
  end
end
