# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  message    :text
#  post_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#

class Comment < ActiveRecord::Base
  validates_presence_of :message, :post_id, :user_id
  validates_length_of :message, :within => 1..600

  belongs_to :post
  belongs_to :user
end
