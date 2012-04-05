# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  message    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#

class Post < ActiveRecord::Base
  validates_presence_of :message, :user_id
  validates_length_of :message, :within => 15..600

  has_many :comments
  belongs_to :user

  default_scope :order => "updated_at DESC"
end
